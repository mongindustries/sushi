#include <application/src/application.hpp>

#define WIN32_LEAN_AND_MEAN

#include <Windows.h>

#include "window.h"
#include "application.h"

using namespace std;

using namespace sushi::wnd;
using namespace sushi::app;

void windowDriverWindows::make      (const shared_ptr<window>& window) {

    auto    app         = application::get_instance();
    auto&   driver      = app->get_driver();

    auto    pdriver     = static_cast<applicationDriverWindows*>(driver.get());

    auto    hinstance   = pdriver->_instance;
    
    auto    exStyle     = WS_EX_LAYERED;

    auto    wTitle      = window->get_title();

    // CreateWindowEx(exStyle, L"SUSHI_APPLICATION", )

}

void windowDriverWindows::kill      (const shared_ptr<window>& window) {


}


void windowDriverWindows::state     (const shared_ptr<window>& window, windowState state) {

}

void windowDriverWindows::message   (const shared_ptr<window>& window, int message, void* data) {

}
