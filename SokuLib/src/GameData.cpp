//
// Created by DPhoenix on 20/06/2023.
//

#include "GameData.hpp"

namespace SokuLib {
	float (&v2::groundHeight)[1280] = *(float (*)[1280])0x8971D8;
	void (*v2::loadDatFile)(const char *path) = (void (*)(const char *path))ADDR_LOAD_DAT;

	v2::GameDataManager*& v2::GameDataManager::instance = *reinterpret_cast<GameDataManager**>(SokuLib::ADDR_GAME_DATA_MANAGER);

	void v2::GameDataManager::createPlayer(int slot, PlayerInfo &info) { (this->*union_cast<void (v2::GameDataManager::*)(int, PlayerInfo &)>(0x46DA40))(slot, info); }

	v2::Player *v2::GameDataManager::createPlayer(PlayerInfo &info) {
		char oldData[0x46DE58 - 0x46DE36];
		DWORD old;

		memcpy(oldData, (void *)0x46DE36, sizeof(oldData));
		VirtualProtect((void *)0x46DE36, sizeof(oldData), PAGE_EXECUTE_READWRITE, &old);
		memset((void *)0x46DE36, 0x90, sizeof(oldData));
		*(unsigned short *)0x46DE36 = 0xC68B; // MOV EAX, ESI
		VirtualProtect((void *)0x46DE36, sizeof(oldData), old, &old);

		Player *object = reinterpret_cast<Player *(__thiscall *)(void *, int, PlayerInfo &)>(0x46DA40)(nullptr, 0, info);

		VirtualProtect((void *)0x46DE36, sizeof(oldData), PAGE_EXECUTE_READWRITE, &old);
		memcpy((void *)0x46DE36, oldData, sizeof(oldData));
		VirtualProtect((void *)0x46DE36, sizeof(oldData), old, &old);
		return object;
	}

	v2::SaveDataManager& v2::SaveDataManager::instance = *reinterpret_cast<SaveDataManager*>(0x899f60);
	void v2::SaveDataManager::enableStage(int stageId) { return (this->*union_cast<void (v2::SaveDataManager::*)(int)>(0x430c60))(stageId); }
	void v2::SaveDataManager::enableCharacter(int characterId) { return (this->*union_cast<void (v2::SaveDataManager::*)(int)>(0x42ee80))(characterId); }
	void v2::SaveDataManager::enableBgm(const char* filename) { return (this->*union_cast<void (v2::SaveDataManager::*)(const char*)>(0x430ca0))(filename); }
	bool v2::SaveDataManager::loadData() { return (this->*union_cast<bool (v2::SaveDataManager::*)()>(0x433330))(); };
	void v2::SaveDataManager::saveData() { return (this->*union_cast<void (v2::SaveDataManager::*)()>(0x42fa10))(); };
	void v2::SaveDataManager::saveScenarioResult(int characterId, unsigned char score)
		{ return (this->*union_cast<void (v2::SaveDataManager::*)(int, unsigned char)>(0x431c20))(characterId, score); }
}
