#include "window.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <stdlib.h>

#include <core/src/application/application.h>
#include <core/src/window/window.h>

#include <core/src/core/str-methods.h>

#include "../ApplicationPayload.h"

void                    window_initialize                   (SU_PREF(struct ma_application) application, SU_PREF(struct te_window) window) {

    SU_PWEAK(ApplicationPayload) payload = (SU_PWEAK(ApplicationPayload)) application->customData;

    struct su_rect  windowPosition  = window->position;

    char*           windowTitle     = su_conv_string    (window->title);
    HWND            windowHwnd      = CreateWindow      (payload->className         ,
                                                         windowTitle                ,
                                                         WS_OVERLAPPEDWINDOW        ,
                                                         (int) windowPosition.location.x  , (int) windowPosition.location.y ,
                                                         (int) windowPosition.size.x      , (int) windowPosition.size.y     ,
                                                         NULL, NULL, payload->instance, NULL);

    ShowWindow      (windowHwnd, SW_SHOW);
    UpdateWindow    (windowHwnd); // may not be required?

    window->customData      = windowHwnd;

    free(windowTitle);
}

void                    window_destroy                      (SU_PREF(struct ma_application) application, SU_PREF(struct te_window) window) {

}


void                    window_dispatch                     (SU_PREF(struct ma_application) application, SU_PREF(struct te_window) window, unsigned int message, SU_PREF(void) data) {


}

struct te_window_driver platform_win_create_driver_window   ()
{
    struct te_window_driver driver = { 0 };

    driver.initialize   = window_initialize;
    driver.dispatch     = window_dispatch;
    driver.destroy      = window_destroy;

    return driver;
}
