#pragma once

#include <core/src/window/window.h>
#include <core/src/window/window-methods.h>

#ifdef __cplusplus
extern "C" {
#endif

struct te_window_driver platform_win_create_driver_window();

#ifdef __cplusplus
}
#endif
