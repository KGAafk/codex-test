// =====================================================================
//  BossMode - 把指定一侧的角色变成 Boss（神早苗）
//  ---------------------------------------------------------------------
//  功能：
//    1) 血量倍率   —— 直接放大 maxHP / hp
//    2) 伤害倍率   —— 放大该角色每一帧的 FrameData::damage
//    3) 体型倍率   —— 放大 renderInfos.scale
//  配置：modules/BossMode/BossMode.ini
//  AI：  用「神AI」(th123_ai.exe) 控制 2P，本 mod 只负责把她变成 Boss
// =====================================================================

#define NOMINMAX
#include <SokuLib.hpp>
#include <algorithm>
#include <cstdio>
#include <cstdarg>
#include <cstdlib>
#include <unordered_set>

namespace {
	struct Config {
		int   bossSide      = 2;     // 1 = 左侧(P1)，2 = 右侧(P2)
		int   bossCharacter = 15;    // 早苗 = 15；填 -1 表示不限制角色
		float hpMult        = 2.5f;  // 血量倍率（hp 是 short，最大 32767 → 上限约 3.2）
		float damageMult    = 2.0f;  // 伤害倍率
		float scaleMult     = 1.6f;  // 体型倍率
	};

	Config g_cfg;
	FILE *g_log = nullptr;
	bool  g_hpApplied = false;
	SokuLib::CharacterManager *g_boss = nullptr;
	std::unordered_set<void *> g_scaledFrames;

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

	void loadConfig()
	{
		const char *ini = "modules\\BossMode\\BossMode.ini";
		char buf[64];

		g_cfg.bossSide      = GetPrivateProfileIntA("Boss", "Side", 2, ini);
		g_cfg.bossCharacter = GetPrivateProfileIntA("Boss", "Character", 15, ini);

		GetPrivateProfileStringA("Boss", "HpMultiplier", "2.5", buf, sizeof(buf), ini);
		g_cfg.hpMult = (float)atof(buf);

		GetPrivateProfileStringA("Boss", "DamageMultiplier", "2.0", buf, sizeof(buf), ini);
		g_cfg.damageMult = (float)atof(buf);

		GetPrivateProfileStringA("Boss", "ScaleMultiplier", "1.6", buf, sizeof(buf), ini);
		g_cfg.scaleMult = (float)atof(buf);

		if (g_cfg.hpMult < 1.f)   g_cfg.hpMult = 1.f;
		if (g_cfg.hpMult > 3.2f)  g_cfg.hpMult = 3.2f;   // hp 是 signed short
		if (g_cfg.damageMult < 1.f) g_cfg.damageMult = 1.f;
		if (g_cfg.scaleMult < 1.f)  g_cfg.scaleMult = 1.f;

		logf("config: side=%d char=%d hp=%.2f dmg=%.2f scale=%.2f\n",
		     g_cfg.bossSide, g_cfg.bossCharacter,
		     g_cfg.hpMult, g_cfg.damageMult, g_cfg.scaleMult);
	}

	// 选出 Boss 那一侧
	bool isBossSide(const SokuLib::CharacterManager &c)
	{
		if (g_cfg.bossCharacter >= 0 && c.characterIndex != g_cfg.bossCharacter)
			return false;
		return true;
	}

	void applyBoss(SokuLib::CharacterManager &boss)
	{
		SokuLib::ObjectManager &obj = boss.objectBase;

		// ---- 1) 血量 ----
		int maxHp = static_cast<int>(10000 * g_cfg.hpMult);

		if (!g_hpApplied) {
			obj.maxHP = static_cast<short>(maxHp);
			obj.hp    = static_cast<short>(maxHp);
			g_hpApplied = true;
			logf("hp set to %d\n", maxHp);
		} else if (obj.maxHP != maxHp) {
			obj.maxHP = static_cast<short>(maxHp);
		}

		// ---- 2) 体型 ----
		obj.renderInfos.scale = SokuLib::Vector2f{g_cfg.scaleMult, g_cfg.scaleMult};

		// ---- 3) 伤害：放大她当前动作帧的伤害值（每个帧数据只放大一次） ----
		if (obj.frameData != nullptr && g_cfg.damageMult > 1.f &&
		    g_scaledFrames.find(obj.frameData) == g_scaledFrames.end()) {
			g_scaledFrames.insert(obj.frameData);

			float dmg = obj.frameData->damage * g_cfg.damageMult;
			if (dmg > 65535.f)
				dmg = 65535.f;
			obj.frameData->damage = static_cast<unsigned short>(dmg);

			float spirit = obj.frameData->spiritDamage * g_cfg.damageMult;
			if (spirit > 65535.f)
				spirit = 65535.f;
			obj.frameData->spiritDamage = static_cast<unsigned short>(spirit);
		}
	}

	int __fastcall CBattleManager_OnProcess(SokuLib::BattleManager *This)
	{
		SokuLib::CharacterManager &left  = This->leftCharacterManager;
		SokuLib::CharacterManager &right = This->rightCharacterManager;
		SokuLib::CharacterManager *boss  = (g_cfg.bossSide == 1) ? &left : &right;

		if (g_boss != boss) {
			g_boss = boss;
			g_hpApplied = false;
			g_scaledFrames.clear();
			logf("boss = side %d, characterIndex %u\n",
			     g_cfg.bossSide, static_cast<unsigned>(boss->characterIndex));
		}

		if (isBossSide(*boss))
			applyBoss(*boss);

		return (This->*g_ogOnProcess)();
	}

	void __fastcall CBattleManager_OnRender(SokuLib::BattleManager *This)
	{
		(This->*g_ogOnRender)();
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

	g_log = fopen("BossMode.log", "w");
	loadConfig();

	VirtualProtect((PVOID)RDATA_SECTION_OFFSET, RDATA_SECTION_SIZE, PAGE_EXECUTE_WRITECOPY, &old);
	g_ogOnProcess = SokuLib::TamperDword(&SokuLib::VTable_BattleManager.onProcess, CBattleManager_OnProcess);
	g_ogOnRender  = SokuLib::TamperDword(&SokuLib::VTable_BattleManager.onRender,  CBattleManager_OnRender);
	VirtualProtect((PVOID)RDATA_SECTION_OFFSET, RDATA_SECTION_SIZE, old, &old);

	logf("BossMode initialized\n");
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
