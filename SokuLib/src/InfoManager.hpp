//
// Created by DPhoenix on 19/07/2023.
//

#ifndef SOKULIB_INFO_MANAGER_HPP
#define SOKULIB_INFO_MANAGER_HPP

#include "Design.hpp"
#include "IEffectManager.hpp"
#include "Player.hpp"

namespace SokuLib {
namespace v2 {

	class InfoManagerBase {
	public:
		void** vtable;
		// 0x004
		EffectManager_InfoEffect effects;
		// 0x098
		CDesign battleUpper, battleUnder, comboGui;
		// 0x134
		char unknown134[0x10];
		// 0x144
		CDesign::Sprite* unknown144[6];
		// 0x15C
		char unknown15C[0x10];
		// 0x16C
		// Contructor:
		// Init:
		// void FUN_00478c50 (HudPlayerState3 *this, CDesignBase *obj, Player *player)
		// FUN_00478c50(this_00, (CDesignBase *)&this->field_0x100, player);
		struct {
			CDesign* design;
			Player* player;
			char unknown08[0x18]; // align 3 on end
			Deque<int> unknown20;
		} state1[2];
		// 0x1D4
		// Contructor:
		// Init:
		// void FUN_00435f10(HudPlayerStateUnknown2 *this, DeckInfo *deckInfo, int index)
		// FUN_00435f10(this, &player->deckInfo, playerIndex);
		struct {
			SokuLib::DeckInfo* deck;
			Sprite unknown004, unknown098;
			char unknown12C[0x28];
		} state2[2];
		// 0x47C
		Sprite* p1Portrait;
		Sprite* p2Portrait;
		int unknown484;
		float unknown488;
		CDesign::Number* unknown48C;
		CDesign::Number* unknown490;
		int unknown494;

		static InfoManagerBase*& instance; // 0x8985e8
	};

	class InfoManager : public InfoManagerBase {
	public:
		// Contructor:
		// void FUN_0047f070(HudPlayerState *param_1, char param_1_00, CDesignBase *param_3, CDesignBase *param_4, int param_5)
		// FUN_0047f070(&this->p1state, 0,(CDesignBase *)&this->field_0x98,(CDesignBase *)&this->field_0xcc,&this->field_0x4);
		// Init:
		// void FUN_0047ede0(HudPlayerState *param_1, Player *param_1_00)
		// FUN_0047ede0(this, player);
		// 0x498
		struct {
			char id;
			// align 3
			float bigCardSize;
			float smallCardRatio;
			int lifebarYellowValue;
			int lifebarRedValue;
			// 0x14
			EffectManager_InfoEffect* effects;
			Player* player;
			CDesign::Gauge* lifebarYellow;
			CDesign::Gauge* lifebarRed;
			// 0x24
			CDesign::Gauge* orbsGauge[5];
			CDesign::Gauge* orbsCrushGauge[5];
			CDesign::Sprite* orbsFull[5];
			CDesign::Sprite* orbsEmpty[5];
			CDesign::Sprite* orbsCrushEmpty[5];
			// 0x88
			CDesign::Gauge* cardGauge[5];
			CDesign::Sprite* cardFaceDown[5];
			CDesign::Sprite* cardSlotA[5];
			CDesign::Sprite* cardSlotB[5];
			// 0xD8
			char unknownD8[0x14];
			// 0xEC
			CDesign::Sprite* winMarkA;
			CDesign::Sprite* winMarkB;
			CDesign::Sprite* winMarkC;
		} playerHUD[2];
	};

}
}

#endif
