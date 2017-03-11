#define WIN32_LEAN_AND_MEAN
#include <Windows.h>

#include "../../../platform/windows/src/application/applicaiton.h"

int CALLBACK WinMain(_In_ HINSTANCE hInstance, _In_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nCmdShow) {

    SU_PSTRONG(ma_application) application = ma_make_application(platform_win_create_driver(), hInstance);

    ma_kill_application(application);

    return 0;
}
