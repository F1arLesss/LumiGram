/*
This file is part of Telegram Desktop,
the official desktop application for the Telegram messaging service.

For license and copyright information please follow this link:
https://github.com/telegramdesktop/tdesktop/blob/master/LEGAL
*/
#pragma once

#include "base/const_string.h"

#define TDESKTOP_REQUESTED_ALPHA_VERSION (0ULL)

#ifdef TDESKTOP_ALLOW_CLOSED_ALPHA
#define TDESKTOP_ALPHA_VERSION TDESKTOP_REQUESTED_ALPHA_VERSION
#else // TDESKTOP_ALLOW_CLOSED_ALPHA
#define TDESKTOP_ALPHA_VERSION (0ULL)
#endif // TDESKTOP_ALLOW_CLOSED_ALPHA

// used in Updater.cpp and Setup.iss for Windows
constexpr auto AppId = "{7E4D3A20-412B-4FB2-B3C5-8B91D2C9D888}"_cs;
constexpr auto AppNameOld = "LumiGram for Windows"_cs;
constexpr auto AppName = "LumiGram Desktop"_cs;
constexpr auto AppFile = "LumiGram"_cs;
constexpr auto AppVersion = 7002009;
constexpr auto AppVersionStr = "7.2.9";
constexpr auto AppBetaVersion = false;
constexpr auto AppAlphaVersion = TDESKTOP_ALPHA_VERSION;
