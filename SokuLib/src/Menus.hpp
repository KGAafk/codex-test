//
// Created by PinkySmile on 05/11/2020.
//

#ifndef SOKULIB_MENUS_HPP
#define SOKULIB_MENUS_HPP


#include <string>
#include "List.hpp"

namespace SokuLib
{
	enum Menu {
		MENU_NONE,
		MENU_CONNECT,
		MENU_REPLAY,
		MENU_MUSICROOM,
		MENU_RESULT,
		MENU_PROFILE,
		MENU_CONFIG,
		MENU_DECK_CONSTRUCTION,
		MENU_KEYS,
		MENU_COUNT
	};

	class IMenu {
	public:
		virtual ~IMenu() = default;
		virtual void _() = 0;
		virtual int onProcess() = 0;
		virtual int onRender() = 0;
	};

	extern void (* const activateMenu)(void *addr);
	extern List<IMenu*> &menuManager;

	template<typename T>
	//! @brief Gives the currently used menu object.
	//! @tparam T The type of the expected object.
	//! @warning Unsafe if not currently in a title screen submenu.
	//! @return The current menu object.
	T *getMenuObj() {
		return reinterpret_cast<T *>(menuManager.back());
	}

	//! @brief Returns the name of the currently active menu.
	std::string getCurrentMenuName();

	Menu getCurrentMenu();

	class MenuCursor {
	public:
		int max = 1, dRows = 0;
		const int* valueAddr = 0; // valueAddr = &inputMgrs.input.<key>;
		int pos = 0, pgPos = 0;

		inline void set(const int* valueAddr, int max = 1, int pos = 0, int dRows = 0) {
			this->max = max;
			this->dRows = dRows;
			this->valueAddr = valueAddr;
			this->pos = this->pgPos = pos;
		}

		bool update();
		void pgDn();
		void pgUp();
		static void render(float x, float y, float width);
	};
}

#include "Menus/ConnectMenu.hpp"
#include "Menus/ProfileDeckEdit.hpp"
#include "Menus/ResultMenu.hpp"

#endif //SOKULIB_MENUS_HPP
