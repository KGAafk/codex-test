// =====================================================================
//  GuardGauge - 东方非想天则 破防槽 Mod
//  ---------------------------------------------------------------------
//  P0：槽常驻显示 + 格挡累积 / 松开回落 + 满槽红闪（不改游戏状态）
//  另外：写 GuardGauge.log，用于确认钩子是否挂上、槽值是否在变。
// =====================================================================

#define NOMINMAX
#include <SokuLib.hpp>
#include <algorithm>
#include <cstring>
#include <cstdio>
#include <cstdarg>

namespace {
	constexpr float GAIN_PER_FRAME  = 0.012f;
	constexpr float DECAY_PER_FRAME = 0.004f;
	constexpr int   BAR_W      = 120;
	constexpr int   BAR_H      = 10;
	constexpr int   BAR_Y      = 400;
	constexpr int   BAR_MARGIN = 20;
	constexpr int   FLASH_TIME = 45;

	struct Gauge {
		float value = 0.f;
		int   flash = 0;
	};

	Gauge g_gauge[2];
	SokuLib::DrawUtils::RectangleShape g_bg[2];
	SokuLib::DrawUtils::RectangleShape g_fill[2];
	SokuLib::SWRFont g_font;
	SokuLib::DrawUtils::Sprite g_title;
	bool g_init = false;

	FILE *g_log = nullptr;
	unsigned g_frames = 0;
	bool g_loggedProcess = false;
	bool g_loggedRender = false;

	int  (SokuLib::BattleManager::*g_ogOnProcess)() = nullptr;
	void (SokuLib::BattleManager::*g_ogOnRender)()  = nullptr;

	void logf(const char *fmt, ...)
	{
		if (g_log == nullptr)
			return;

		va_list args;
		va_start(args, fmt);
		vfprintf(g_log, fmt, args);
		va_end(args);
		fflush(g_log);
	}

	bool isBlocking(const SokuLib::CharacterManager &c)
	{
		const SokuLib::ObjectManager &obj = c.objectBase;

		if (obj.frameData != nullptr && obj.frameData->frameFlags.guarding)
			return true;
		return obj.action >= SokuLib::ACTION_RIGHTBLOCK_HIGH_SMALL_BLOCKSTUN &&
		       obj.action <= SokuLib::ACTION_WRONGBLOCK_LOW_HUGE_BLOCKSTUN;
	}

	void initAll()
	{
		for (int i = 0; i < 2; ++i) {
			int x = (i == 0) ? BAR_MARGIN : 640 - BAR_MARGIN - BAR_W;

			g_bg[i].setSize(SokuLib::Vector2u{BAR_W, BAR_H});
			g_bg[i].setPosition(SokuLib::Vector2i{x, BAR_Y});
			g_bg[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(0, 0, 0, 180));
			g_bg[i].setBorderColor(SokuLib::DrawUtils::DxSokuColor(255, 255, 255, 140));

			g_fill[i].setSize(SokuLib::Vector2u{0, BAR_H});
			g_fill[i].setPosition(SokuLib::Vector2i{x, BAR_Y});
			g_fill[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(80, 200, 255, 210));
			g_fill[i].setBorderColor(SokuLib::DrawUtils::DxSokuColor(0, 0, 0, 0));
		}

		// 标题文字：能看到它就说明绘制通路是通的
		SokuLib::FontDescription desc;
		desc.r1 = 255; desc.r2 = 255;
		desc.g1 = 255; desc.g2 = 255;
		desc.b1 = 255; desc.b2 = 255;
		desc.height = 16;
		desc.weight = FW_BOLD;
		desc.italic = 0;
		desc.shadow = 4;
		desc.bufferSize = 1000000;
		desc.charSpaceX = 0;
		desc.charSpaceY = 0;
		desc.offsetX = 0;
		desc.offsetY = 0;
		desc.useOffset = 0;
		strcpy(desc.faceName, "MonoSpatialModSWR");
		g_font.create();
		g_font.setIndirect(desc);

		SokuLib::Vector2<int> realSize;
		if (g_title.texture.createFromText("GUARD GAUGE", g_font, {400, 40}, &realSize)) {
			g_title.setSize(realSize.to<unsigned>());
			g_title.rect.width = realSize.x;
			g_title.rect.height = realSize.y;
			g_title.setPosition(SokuLib::Vector2i{320 - realSize.x / 2, 70});
		} else {
			logf("createFromText failed\n");
		}
	}

	void updateGauge(Gauge &g, bool blocking)
	{
		if (blocking)
			g.value = (std::min)(1.0f, g.value + GAIN_PER_FRAME);
		else
			g.value = (std::max)(0.0f, g.value - DECAY_PER_FRAME);

		if (g.value >= 1.0f) {
			g.value = 0.0f;
			g.flash = FLASH_TIME;
		}
		if (g.flash > 0)
			--g.flash;
	}

	void drawGauge(int i)
	{
		const Gauge &g = g_gauge[i];

		// 空槽也画，保证一眼能看到
		g_bg[i].draw();

		int w = (g.flash > 0) ? BAR_W : static_cast<int>(BAR_W * g.value);
		if (w <= 0)
			return;

		g_fill[i].setSize(SokuLib::Vector2u{static_cast<unsigned>(w), BAR_H});
		if (g.flash > 0)
			g_fill[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(255, 40, 40, 235));
		else
			g_fill[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(80, 200, 255, 210));
		g_fill[i].draw();
	}

	int __fastcall CBattleManager_OnProcess(SokuLib::BattleManager *This)
	{
		if (!g_init) {
			initAll();
			g_init = true;
		}
		if (!g_loggedProcess) {
			g_loggedProcess = true;
			logf("onProcess: first call\n");
		}

		const SokuLib::CharacterManager &left  = This->leftCharacterManager;
		const SokuLib::CharacterManager &right = This->rightCharacterManager;

		updateGauge(g_gauge[0], isBlocking(left));
		updateGauge(g_gauge[1], isBlocking(right));

		++g_frames;
		if (g_frames % 120 == 0)
			logf("frame=%u L(action=%u guard=%d v=%.2f) R(action=%u guard=%d v=%.2f)\n",
			     g_frames,
			     static_cast<unsigned>(left.objectBase.action),
			     isBlocking(left) ? 1 : 0, g_gauge[0].value,
			     static_cast<unsigned>(right.objectBase.action),
			     isBlocking(right) ? 1 : 0, g_gauge[1].value);

		return (This->*g_ogOnProcess)();
	}

	void __fastcall CBattleManager_OnRender(SokuLib::BattleManager *This)
	{
		(This->*g_ogOnRender)();

		if (!g_loggedRender) {
			g_loggedRender = true;
			logf("onRender: first call\n");
		}

		g_title.draw();
		drawGauge(0);
		drawGauge(1);
	}
}

extern "C" __declspec(dllexport) bool CheckVersion(const BYTE hash[16])
{
	return memcmp(hash, SokuLib::targetHash, sizeof(SokuLib::targetHash)) == 0;
}

extern "C" __declspec(dllexport) bool Initialize(HMODULE hMyModule, HMODULE hParentModule)
{
	DWORD old;

	(void)hMyModule;
	(void)hParentModule;

	g_log = fopen("GuardGauge.log", "w");
	if (g_log != nullptr)
		logf("Initialize ok, targetHash matched\n");

	VirtualProtect((PVOID)RDATA_SECTION_OFFSET, RDATA_SECTION_SIZE, PAGE_EXECUTE_WRITECOPY, &old);
	g_ogOnProcess = SokuLib::TamperDword(&SokuLib::VTable_BattleManager.onProcess, CBattleManager_OnProcess);
	g_ogOnRender  = SokuLib::TamperDword(&SokuLib::VTable_BattleManager.onRender,  CBattleManager_OnRender);
	VirtualProtect((PVOID)RDATA_SECTION_OFFSET, RDATA_SECTION_SIZE, old, &old);

	logf("hooks installed: process=%d render=%d\n", g_ogOnProcess != nullptr, g_ogOnRender != nullptr);

	FlushInstructionCache(GetCurrentProcess(), nullptr, 0);
	return true;
}

extern "C" int APIENTRY DllMain(HMODULE hModule, DWORD fdwReason, LPVOID lpReserved)
{
	return TRUE;
}

extern "C" __declspec(dllexport) int getPriority()
{
	return 0;
}
