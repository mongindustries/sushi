#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include "../../platform/windows/src/application/application.h"
#include "../../platform/windows/src/window/window.h"

#include "../../core/src/core/rect-methods.h"

int CALLBACK WinMain(_In_ HINSTANCE hInstance, _In_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nCmdShow) {

    SU_PSTRONG(ma_application)  application = ma_make_application   (platform_win_create_driver_app(), hInstance);

    SU_PSTRONG(te_window)       window      = te_make_window        (application                            ,
                                                                     su_make_string ("Sample Application!") ,
                                                                     su_make_rect   (300, 100, 500, 350)    );

            ma_loop_application (application);

            te_kill_window      (application, window);

    return  ma_kill_application (application);
}
