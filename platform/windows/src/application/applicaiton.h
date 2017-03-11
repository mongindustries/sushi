#pragma once

#include "../../../../core/src/application/application.h"
#include "../../../../core/src/application/application-methods.h"

#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

struct ma_application_driver platform_win_create_driver();
