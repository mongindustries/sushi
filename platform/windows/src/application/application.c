#include "application.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <stdlib.h>

#include "../window/window.h"
#include "../ApplicationPayload.h"

LPARAM CALLBACK                 application_wndProc             (HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam) {

    switch (message)
    {
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    }

    return DefWindowProc(hwnd, message, wparam, lparam);
}


void                            application_initialize          (SU_PREF(struct ma_application) application, SU_PREF(void) customData) {

    SU_PSTRONG(ApplicationPayload) payload = (SU_PSTRONG(ApplicationPayload)) calloc(1, sizeof(ApplicationPayload));

    payload->className      = "sushi_maki_application";
    payload->instance       = customData;

    application->customData = payload;

    WNDCLASSEX wcex         = { 0 };

    wcex.cbSize             = sizeof(WNDCLASSEX);
    wcex.cbClsExtra         = sizeof(ApplicationPayload);
    wcex.cbWndExtra         = 0;

    wcex.style              = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc        = application_wndProc;
    wcex.hInstance          = customData;
    wcex.hIcon              = LoadIcon(customData, MAKEINTRESOURCE(IDI_APPLICATION));
    wcex.hCursor            = LoadCursor(NULL, IDC_ARROW);
    wcex.hbrBackground      = (HBRUSH)(COLOR_WINDOW + 1);
    wcex.lpszMenuName       = NULL;
    wcex.lpszClassName      = "sushi_maki_application";
    wcex.hIconSm            = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_APPLICATION));

    HRESULT registerClass   = RegisterClassEx(&wcex);

    if (registerClass != S_OK) {

        // TODO: throw a fatal error here!
    }

    SetClassLongPtr()
}

void                            application_destroy             (SU_PREF(struct ma_application) application) {

    if (application->customData != NULL) {

        free(application->customData);
        application->customData = NULL;
    }
}

void                            appliation_loop                 (SU_PREF(struct ma_application) application) {

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {

        TranslateMessage    (&msg);
        DispatchMessage     (&msg);
    }
}


struct ma_application_driver    platform_win_create_driver_app  () {

    struct ma_application_driver    driver          = { 0 };
    struct te_window_driver         driver_window   = platform_win_create_driver_window();

    driver.initialize       = application_initialize;
    driver.destroy          = application_destroy;
    driver.loop             = appliation_loop;

    driver.window_driver    = (SU_PSTRONG(struct te_window_driver)) malloc(sizeof(struct te_window_driver));
    memcpy(driver.window_driver, &driver_window, sizeof(struct te_window_driver));

    return driver;
}
