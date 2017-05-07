#include "application.h"

using namespace sushi::app;

applicationDriverWindows::applicationDriverWindows  ():

    _instance(nullptr)
{
}


void    applicationDriverWindows::initialize        (application* const application, void* const data) const {

    _instance               = static_cast<HINSTANCE>(data);

    // create application here

    auto wndclass           = WNDCLASSEX { 0 };

    wndclass.cbSize         = sizeof(WNDCLASSEX);
    wndclass.style          = CS_HREDRAW | CS_VREDRAW;
    wndclass.lpfnWndProc    = WNDPROC;
    wndclass.cbClsExtra     = 0;
    wndclass.cbWndExtra     = 0;
    wndclass.hInstance      = _instance;
    wndclass.hIcon          = LoadIcon(_instance, MAKEINTRESOURCE(IDI_APPLICATION));
    wndclass.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wndclass.hbrBackground  = reinterpret_cast<HBRUSH>(COLOR_WINDOW + 1);
    wndclass.lpszMenuName   = nullptr;
    wndclass.lpszClassName  = L"SUSHI_APPLICATION";
    wndclass.hIconSm        = LoadIcon(_instance, MAKEINTRESOURCE(IDI_APPLICATION));

    auto classAtom          = RegisterClassEx(&wndclass);

    if (classAtom == 0) {
        
        // Application failure! Cannot continue program execution.
    }
}

void    applicationDriverWindows::destroy           (application* const application) const {

}


void    applicationDriverWindows::run               (application* const application) const {

    MSG msg;

    while (GetMessage(&msg, nullptr, 0, 0)) {

        TranslateMessage    (&msg);
        DispatchMessage     (&msg);
    }
}


LRESULT applicationDriverWindows::WNDPROC           (HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam) {

    return DefWindowProc(hwnd, message, wparam, lparam);
}
