//
// Created by PinkySmile on 02/12/2020.
//

#include "InfoManager.hpp"

namespace SokuLib::v2
{
	InfoManagerBase*& InfoManagerBase::instance = *reinterpret_cast<InfoManagerBase **>(0x8985E8);
}