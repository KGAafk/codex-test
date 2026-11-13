//
// Created by DPhoenix on 20/09/2022.
//

#ifndef SOKULIB_PLAYER_HPP
#define SOKULIB_PLAYER_HPP

#include "GameObject.hpp"
#include "Deque.hpp"
#include "Character.hpp"

namespace SokuLib {
namespace v2 {
	class Player : public GameObjectBase {
	public:
		// offset 0x34C
		Character characterIndex;
		char teamId;
		char paletteId;
		char unknown352[0x2]; // align 0x2?
		int portraitTexId = 0;
		Sprite portrait;

		// offset 0x3EC
		struct StandInfo {
			int texId = 0;
			Sprite sprite;

			// offset 0x484
			int playerId;
			int unknown488; // 0x46eb80: = -1;
			Vector2f unknown48C; // some coord
			char unknown494;
			// align 3

			//void FUN_46ec50();
		} stand;

		union ComboModifers {
			char value;
			struct {
				/* 0x01 */ bool liftAttack: 1;
				/* 0x02 */ bool smashAttack: 1;
				/* 0x04 */ bool borderResist: 1;
				/* 0x08 */ bool chainArt: 1;
				/* 0x10 */ bool chainSpell: 1;
				/* 0x20 */ bool counter: 1;
			};
		};

		// offset 0x498
		short redHP;
		char groundDashCount, airDashCount, unknown49C, unknown49D; // = 0
		short currentSpirit, maxSpirit; // = 100
		short spiritRegenDelay, timeWithBrokenOrb, spellStopCounter, timeStop, unknown4AA; // = 0
		char unknown4AC;
		ComboModifers comboModifiers; // = 0
		char unknown4AE[2]; // align 2?
		float comboRate; // = 1.0
		short comboCount, comboDamage, comboLimit, untech;
		short unknown4BC, realLimit; // = 0
		short unknown4C0, unknown4C2; // = 0
		char unknown4C4, unknown4C5; // 48b000: +0x4c4 = 0 align 1?
		short unknown4C6; // = 0
		int skillCancelCount; // = 0
		char unknown4CC, hasSpotlight; // = 0
		short spotlightStrength; // = 0
		float speedPower; // = 1.0
		short riverMistCounter, unknown4D6; // = 0
		char unknown4D8; // = 0
		char unknown4D9[3]; // align 3?
		int unknown4DC[16]; // = 0
		short meleeInvulTimer, grabInvulTimer, projectileInvulTimer, grazeTimer; // = 0
		short confusionDebuffTimer, SORDebuffTimer, healCharmTimer; // = 0
		char unknown52A, unknown52B; // 48b000: +0x52A = 0 align 1?
		int weatherId; // = 0;

		// 0x530: = {1,1,1,1, 0,1,1,1, 0,0,0,1};
		float attackPower;
		float defensePower;
		float unknown538;
		float unknown53C;
		float bonusProration;
		float spellDmgMultiplier;
		float specialDmgMultiplier;
		float meterGainMultiplier;
		float lifeStealMultiplier;
		float discardMultiplier;
		float reflectDamageMultiplier; // Normally at 0. Used for Suwako's blue curse
		float unknown55C;

		short grimoireCount; // = 0
		char unknown562[2]; // align 2?
		float speedXMultiplier, speedYMultiplier;

		// 0x56C: = {0,0,0,0, 0,1,1,0, 0,0,0,0, 0,?,?,?};
		bool canGrazeMelee, crushOnWB, skillsMax, unknown56F;
		bool unknown570, lockedInStageX, lockedInStageY; unsigned char score;
		unsigned char roundsWins, unknown575, unknown576, kdAnimationFinished, unknown578;
		unsigned char unknown579[3]; // align 3?

		//offset 0x57c
		struct DeckInfo {
			Deque<int> textures;
			Map<int, SokuLib::CardInfo> cardById;
			Deque<unsigned short> original;
			Deque<unsigned short> queue;
			unsigned char availSkills[32]; // 435a50: for (cardById) if (type = skill) availSkills[CardData.costOrSlot] = id

			SokuLib::CardInfo* cardLookup(unsigned short id);
		} deckInfo;

		// offset 0x5e4
		struct HandInfo {
			short cardGauge;
			unsigned char cardCount;
			unsigned char cardSlots;

			Deque<SokuLib::Card> hand;
			Deque<unsigned short> usedCards;
		} handInfo;

		// offset 0x610
		Sprite unknown610;
		// offset 0x6A4
		char effectiveSkillLevel[32]; // this one starts as 0
		char skilledSkillLevel[32]; // this one starts as -1 (except the first four reset in: 48b000)
		int unknown6E4, unknown6E8; // 46b9a0: = 0
		int unknown6EC, unknown6F0; // 46b9a0: = -1
		char unknown6F4, unknown6F5; // 46b9a0: = 0
		char unknown6F6[2]; // align 2?

		// offset 0x6f8
		IGameObjectList* objectList;
		Deque<CharacterSequenceData> patternData;
		int unknown710; // 46b9a0: = 0

		struct {
			List<SpriteEx> unknown714; // unsure (maybe struct {SpriteEx,byte})
			char unknown720 = 5;
			char unknown721;
			short unknown722 = 15;
			char unknown724[4];
			char unknown728; // 46b9a0: = 0
			char unknown729[3];
		} unknown714;

		Deque<int> spellBgTextures;
		short spellBgTimer; // = 0
		unsigned char spellBgId;
		char unknown743;
		Vector2f additionalSpeed; // 46b9a0: = .0
		float riverMistAdditionalSpeed; // 46b9a0: = .0

		// offset 0x750
		KeyManager* keyManager;
		struct InputInfo {
			// offset 0x754
			KeyInputLight keyInput; // sizeof = 0x20
			// offset 0x774
			KeyInputLight bufferedKeyInput;
			// offset 0x794
			int keyUpA, keyUpB, keyUpC, keyUpD, keyUpE, keyUpF; // 46cac0: = 0;
			char bufferTimer; // 46cac0: = 0;
			char unknown7AD[3]; // align 3?
			// offset 0x7B0
			Deque<unsigned short> commandInputBuffer;
			MovementCombination movementCombination; // 46b9a0: = 0
			CommandCombination commandCombination; // 46b9a0: = 0
			char inputType = 0; // type of input? (checks for 0, 1 or 2)
			// align 0x3
		} inputData;

		short gpShort[6]; // 0x7D0 - 0x7DA
		float gpFloat[6]; // 0x7DC - 0x7F0
		bool chargedAttack;
		bool blockObjectSpawned;
		char unknown7F6;
		bool damageLimited; // = 0;
		short unknown7F8; // = 0;
		char unknown7FA[2]; // align 2?
		float unknown7FC; // = .0;
		bool skillCancelsUsed[5]; // = 0;
		char unknown805[3]; // align 3?
		float riverMistTimer; // = .0;
		char unknown80C; // 48b000: (+80D, +80E) = .0; (+80D = isAuraActive)
		char unknown80D; // 48b000: (+80D, +80E) = .0; (+80D = isAuraActive)
		bool isBELocked; // Automatically set to true when opponent is in a spell animation (between 600 and 688)
		char unknown80F; // 48b000: (+80D, +80E) = .0; (+80D = isAuraActive)
		int unknown810, unknown814; // 48b000: = 0; (auraFXDelay, auraDuration)
		short unknown818[10]; // = 0;
		float unknown82C, unknown830; // = .0;
		short tenguFans; // = 0;
		char unknown836; // +0x836 = 0; align 1?
		char unknown837;
		float unknown838; // = .0;
		char unknown83C; // = 0;
		char unknown83D[3]; // align 3?
		float sacrificialDolls, controlRod, magicPotionTimeLeft; // = .0;
		short stopwatchTimeLeft, dragonStarTimeLeft, drops, dropInvulTimeLeft; // = 0;
		float unknown854;
		float unknown858;
		float unknown85C;
		float unknown860;
		float unknown864; // = .0;
		char unknown868; // +0x868 = 0; align 1?
		char unknown869;
		short unknown86A; // = 0;
		int unknown86C; // = 0;
		int unknown870;
		int unknown874;
		int unknown878;
		int unknown87C;
		char unknown880;
		char unknown881; // +0x880 = 0; align 1?
		short unknown882;
		short unknown884;
		short unknown886;
		short unknown888;
		short unknown88A;
		Vector2<short> spinRotationCenter = {0, 0};
		// found shared data until size: 0x890 (0x48b088: short this[0x88e])

		Player(const PlayerInfo& playerInfo);
		~Player() override;

		void initializeAction() override;
		void applyTransform() override;
		void updatePhysics() override;
		virtual void initialize(); // character specific initialization
		virtual bool VUnknown48(); // check for landing
		virtual bool VUnknown4C(int a); // something with actionId in [700,799]
		virtual void handleInputs() = 0; // seems to handle inputs (differs for each character)
		virtual void checkAllMotionInputs(); // compare input buffer for sequences
		virtual void VUnknown58() = 0;
		virtual void VUnknown5C() = 0;
		virtual bool VUnknown60(int a) = 0;

		// Gets the character from this->characterIndex
		void loadResources(); // 0x46c0b0
		bool updateGroundMovement(float value); // 0x487740
		float decideShotAngle(float, float); // 0x4877C0
		void addCardMeter(int); // 0x487870
		bool handleCardSwitch(); // 0x487890 input related
		bool useSystemCard(int moveLock); // 0x48a700
		bool canSpendSpirit(); // 0x4878c0 input related (canSpendSpirit???)
		unsigned short getMoveLock(unsigned short action); // 0x489610
		bool canActivateCard(int slot);// 0x468e80
		bool handleHJ(); // 0x487900 input related
		bool handleHJInput(int moveLock, int hjCancelable); // 0x489e90
		bool handleGroundDash(int moveLock, int hjCancelable); // 0x48a220
		bool handleGroundBE(); // 0x487990 input related
		bool handleAirBE(); // 0x487ab0 input related
		bool handleFwdAirDash(int moveLock, int hjCancelable, int allowedAirMoves, int airDashCancelSeq); // 0x48a380
		bool handleBackAirDash(int moveLock, int hjCancelable, int allowedAirMoves, int airDashCancelSeq); // 0x48a470
		bool handleNormalFlight(int moveLock, int hjCancelable, int allowedAirMoves); // 0x48a560
		void useSpellCard(int id, short action); // 0x487b60 (+0x4ad flag 0x10)
		void useSkill(int id, short action); // 0x487ba0 (+0x4ad flag 0x08)
		void onSkillUpgrade(); // 0x489660
		void checkTurnAround(); // swapDirection?
		void playSpellBackground(int id, int timer);
		bool applyGroundMechanics(); // 0x487ca0
		// 0x487e90 always returns zero
		bool applyAirMechanics(); // 0x487ea0
		void playSFX(int id); // 0x464980
		void consumeSpirit(int cost, int delay); // 0x47a9e0
		void consumeCard(int index = 0, int costOverride = 0, int cardNameTimer = 60); // 0x469c70
		void eventSkillUse(); // 0x483ce0
		void eventSpellUse(); // 0x483d60
		void eventWeatherCycle(); // 0x483db0
		void FUN_0046d950(); // 0x46d950
		bool isGrounded(); // 0x463530
		void updateDefaultBehavior();
		SokuLib::v2::GameObject* createObject(short action, float x, float y, char direction, char layer, float *extraData, unsigned int extraDataSize); // 46eb30

		template<size_t size>
		SokuLib::v2::GameObject *createObject(short action, float x, float y, char direction, char layer, float (&extraData)[size]) {
			// Mimics 0x46EB30
			return this->objectList->createObject(nullptr, this, action, x, y, direction, layer, extraData, size);
		}
		SokuLib::v2::GameObject *createObject(short action, float x, float y, char direction, char layer) {
			// Mimics 0x46EB30
			return this->objectList->createObject(nullptr, this, action, x, y, direction, layer, nullptr, 0);
		}

		template<typename T, typename = std::enable_if_t<std::is_base_of_v<Player, T>>>
		T &to() {
			return *reinterpret_cast<T *>(this);
		}

		template<typename T, typename = std::enable_if_t<std::is_base_of_v<Player, T>>>
		T &to() const {
			return *reinterpret_cast<const T *>(this);
		}
	};
	static_assert(sizeof(Player) == 0x890);

#define DECL_PLAYER_VIRTUALS() \
	void setActionSequence(short, short) override; \
	bool setAction(short) override; \
	void setSequence(short) override; \
	void resetSequence() override; \
	bool nextSequence() override; \
	void prevSequence() override; \
	void setPose(short) override; \
	bool nextPose() override; \
	void prevPose() override; \
	void update() override; \
	void render() override; \
	void render2() override; \
	void applyTransform() override; \
	void onRenderEnd() override; \
	void initializeAction() override; \
	void updatePhysics() override; \
	void initialize() override; \
	bool VUnknown48() override; \
	bool VUnknown4C(int a) override; \
	void handleInputs() override; \
	void checkAllMotionInputs() override; \
	void VUnknown58() override; \
	void VUnknown5C() override; \
	bool VUnknown60(int a) override;

	class PlayerReimu : public Player {
	public:
		char unknown890[0x24];
		unsigned short fantasyHeavenTimer;
		unsigned short fantasyHeavenStacks;
		char unknown8B8[0x4];

		PlayerReimu(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerReimu) == 0x8BC);

	class PlayerMarisa : public Player {
	public:
		char unknown890[0x2];
		unsigned short orreriesTimer;
		char unknown894[0x18];

		PlayerMarisa(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerMarisa) == 0x8AC);

	class PlayerSakuya : public Player {
	public:
		unsigned short worldTimer;
		unsigned short psTimer;
		char unknown894[0xC];

		PlayerSakuya(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerSakuya) == 0x8A0);

	class PlayerAlice : public Player {
	public:
		char unknown890[0x2];
		unsigned short dollCount;
		char unknown894[0x30];

		PlayerAlice(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerAlice) == 0x8C4);

	class PlayerPatchouli : public Player {
	public:
		unsigned short philStoneTimer;
		char unknown892[0xE];
		unsigned short dHardnessTimer;
		char unknown8A2[0x6];

		PlayerPatchouli(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerPatchouli) == 0x8A8);

	class PlayerYoumu : public Player {
	public:
		char unknown890[0x2C];
		void *unknownObject;
		char unknown8C0[0x16];
		unsigned short youmuCloneTimeLeft;
		char unknown8D8[0x14];

		PlayerYoumu(const PlayerInfo&);
		~PlayerYoumu() override;
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerYoumu) == 0x8EC);

	class PlayerRemilia : public Player {
	public:
		unsigned short millVampireTimer;
		char unknown892[0x02];

		PlayerRemilia(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerRemilia) == 0x894);

	class PlayerYuyuko : public Player {
	public:
		char unknown890[0x10];
		unsigned short resButterfliesUsed;
		char unknown8A2[0xA];

		PlayerYuyuko(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerYuyuko) == 0x8AC);

	class PlayerYukari : public Player {
	public:
		char unknown890[0x44];

		PlayerYukari(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerYukari) == 0x8D4);

	class PlayerSuika : public Player {
	public:
		char unknown890[0x2];
		unsigned short mppTimer;
		char unknown894[0x4];

		PlayerSuika(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerSuika) == 0x898);

	class PlayerUdonge : public Player {
	public:
		char unknown890[0x8];
		unsigned short urFieldActive;
		unsigned short uvFieldActive;
		char unknown89C[0x4];
		unsigned short elixirUsed;
		char unknown8A2[0x10];
		unsigned short infraredMoonTimeLeft;
		char unknown8B4[0x4];

		PlayerUdonge(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerUdonge) == 0x8B8);

	class PlayerAya : public Player {
	public:
		char unknown890[0x08];

		PlayerAya(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerAya) == 0x898);

	class PlayerKomachi : public Player {
	public:
		char unknown890[0x08];

		PlayerKomachi(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerKomachi) == 0x898);

	class PlayerIku : public Player {
	public:
		char unknown890[0x18];

		PlayerIku(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerIku) == 0x8A8);

	class PlayerTenshi : public Player {
	public:
		char unknown890[0x94];
		unsigned short stateOfEnlightenmentTimeLeft;
		char unknown926[0xA];

		PlayerTenshi(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	}; // TODO There's something wrong with Tenshi
	static_assert(sizeof(PlayerTenshi) == 0x930);

	class PlayerSanae : public Player {
	public:
		char unknown890[0xC];
		int kanakoTimer;
		int suwakoTimeLeft;
		char unknown8A4[0xC];

		PlayerSanae(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerSanae) == 0x8B0);

	class PlayerChirno : public Player {
	public:
		char unknown890[0x04];

		PlayerChirno(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerChirno) == 0x894);

	class PlayerMeirin : public Player {
	public:
		char unknown890[0x04];

		PlayerMeirin(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerMeirin) == 0x894);

	class PlayerUtsuho : public Player {
	public:
		bool capeDisabled;
		int capeTexture;
		char unknown898[0x10];

		PlayerUtsuho(const PlayerInfo&);
		~PlayerUtsuho() override;
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerUtsuho) == 0x8A8);

	class PlayerSuwako : public Player {
	public:
		char unknown890[4];
		int curseType;//0x894, enum {None=0, Red, Green, Blue}
		int punishType;//0x898, enum {None=0, Crush, Block, Attack, Dash}
		bool orbsSpawned;//0x89C
		bool orbsFastSpin;//0x89D(unused)
		char unknown89E[2];//align 2
		int curseTimer;//0x8A0
		int punishTimer;//0x8A4

		PlayerSuwako(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerSuwako) == 0x8A8);

	class PlayerNamazu : public Player {
	public:
		char unknown890[0x10];

		PlayerNamazu(const PlayerInfo&);
		DECL_PLAYER_VIRTUALS()
	};
	static_assert(sizeof(PlayerNamazu) == 0x8A0);
}}

#endif