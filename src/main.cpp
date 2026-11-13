// =====================================================================
//  GuardGauge - 东方非想天则 破防槽 Mod
//  ---------------------------------------------------------------------
//  机制：格挡时累积「破防槽」，不格挡时缓慢回落；
//        槽满后触发破防（当前版本 P0：只做槽的显示与累积/回落，
//        满槽会红闪但暂不改变游戏状态，便于先验证整条编译与运行链路）。
//
//  目标版本：th123 1.10a (MD5 DF35D1FBC7B583317ADABE8CD9F53B2E)
//  依赖：SokuLib / SokuModLoader
// =====================================================================

#define NOMINMAX
#include <SokuLib.hpp>
#include <algorithm>
#include <cstring>

namespace {
	constexpr float GAIN_PER_FRAME  = 0.012f;   // 每帧格挡累积
	constexpr float DECAY_PER_FRAME = 0.004f;   // 每帧不格挡回落
	constexpr int   BAR_W      = 120;
	constexpr int   BAR_H      = 8;
	constexpr int   BAR_Y      = 430;
	constexpr int   BAR_MARGIN = 16;
	constexpr int   FLASH_TIME = 45;

	struct Gauge {
		float value = 0.f;   // 0..1
		int   flash = 0;     // >0 时闪红
	};

	Gauge g_gauge[2];
	SokuLib::DrawUtils::RectangleShape g_bg[2];
	SokuLib::DrawUtils::RectangleShape g_fill[2];
	bool g_init = false;

	int  (SokuLib::BattleManager::*g_ogOnProcess)() = nullptr;
	void (SokuLib::BattleManager::*g_ogOnRender)()  = nullptr;

	// 是否处于格挡状态：优先看 FrameData 的 guarding 位，
	// 再兜底看动作编号是否落在格挡硬直区间（含空中格挡）。
	// 注意：动作与帧数据挂在 CharacterManager::objectBase 上，
	//       格挡位是 frameFlags 联合体里的 guarding。
	bool isBlocking(const SokuLib::CharacterManager &c)
	{
		const SokuLib::ObjectManager &obj = c.objectBase;

		if (obj.frameData != nullptr && obj.frameData->frameFlags.guarding)
			return true;
		return obj.action >= SokuLib::ACTION_RIGHTBLOCK_HIGH_SMALL_BLOCKSTUN &&
		       obj.action <= SokuLib::ACTION_WRONGBLOCK_LOW_HUGE_BLOCKSTUN;
	}

	void initBars()
	{
		for (int i = 0; i < 2; ++i) {
			int x = (i == 0) ? BAR_MARGIN : 640 - BAR_MARGIN - BAR_W;

			g_bg[i].setPosition(SokuLib::Vector2i{x, BAR_Y});
			g_bg[i].setSize(SokuLib::Vector2u{BAR_W, BAR_H});
			g_bg[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(0, 0, 0, 160));
			g_bg[i].setBorderColor(SokuLib::DrawUtils::DxSokuColor(255, 255, 255, 80));

			g_fill[i].setPosition(SokuLib::Vector2i{x, BAR_Y});
			g_fill[i].setSize(SokuLib::Vector2u{BAR_W, BAR_H});
			g_fill[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(80, 200, 255, 200));
			g_fill[i].setBorderColor(SokuLib::DrawUtils::DxSokuColor(255, 255, 255, 0));
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

	void drawBar(int i)
	{
		const Gauge &g = g_gauge[i];

		if (g.value <= 0.0f && g.flash <= 0)
			return;

		g_bg[i].draw();

		int w = (g.flash > 0) ? BAR_W : static_cast<int>(BAR_W * g.value);
		if (w <= 0)
			return;

		g_fill[i].setSize(SokuLib::Vector2u{static_cast<unsigned>(w), BAR_H});
		if (g.flash > 0)
			g_fill[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(255, 40, 40, 230));
		else
			g_fill[i].setFillColor(SokuLib::DrawUtils::DxSokuColor(80, 200, 255, 200));
		g_fill[i].draw();
	}

	int __fastcall CBattleManager_OnProcess(SokuLib::BattleManager *This)
	{
		if (!g_init) {
			initBars();
			g_init = true;
		}

		updateGauge(g_gauge[0], isBlocking(This->leftCharacterManager));
		updateGauge(g_gauge[1], isBlocking(This->rightCharacterManager));

		return (This->*g_ogOnProcess)();
	}

	void __fastcall CBattleManager_OnRender(SokuLib::BattleManager *This)
	{
		(This->*g_ogOnRender)();

		drawBar(0);
		drawBar(1);
	}
}

// 校验游戏版本（1.10a）
extern "C" __declspec(dllexport) bool CheckVersion(const BYTE hash[16])
{
	return memcmp(hash, SokuLib::targetHash, sizeof(SokuLib::targetHash)) == 0;
}

// 由 mod loader 调用，在这里装钩子
extern "C" __declspec(dllexport) bool Initialize(HMODULE hMyModule, HMODULE hParentModule)
{
	DWORD old;

	(void)hMyModule;
	(void)hParentModule;

	VirtualProtect((PVOID)RDATA_SECTION_OFFSET, RDATA_SECTION_SIZE, PAGE_EXECUTE_WRITECOPY, &old);
	g_ogOnProcess = SokuLib::TamperDword(&SokuLib::VTable_BattleManager.onProcess, CBattleManager_OnProcess);
	g_ogOnRender  = SokuLib::TamperDword(&SokuLib::VTable_BattleManager.onRender,  CBattleManager_OnRender);
	VirtualProtect((PVOID)RDATA_SECTION_OFFSET, RDATA_SECTION_SIZE, old, &old);

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
