// window.cpp
// sushiwindow - sushicpp
// 
// Created: 13:20 08/19/2017
// Author: Michael Ong

#include "../window.hpp"
#include "../windowLogic.hpp"

using namespace sushi::core;

using namespace sushi::window;
using namespace sushi::drivers;


Window::Window                   (WindowDriver* driver, WindowLogic* logic):

    CoreObject              (),
    WindowDriverDelegate    (),

    _dpi                    (0),
    _title                  (u"Title Goes Here!"),
    _windowState            (0),

    _windowDriver           (driver),
    _graphicsSurface        (nullptr),
    _inputDispatcher        (nullptr),

    _windowLogic            (logic) {

    _windowDriver->delegate = this;
    _windowLogic->window = this;
}

Window::~Window                 () {

    delete _windowLogic;
    delete _windowDriver;
}


void Window::setLocation        (const Rectangle& value) {

    if (_location != value) {

        _location = value;

        // TODO: add checker for undefined rectangle

        auto valuePass = new Rectangle(value);
        _windowDriver->process(WindowDriverMessages::sizeChanged, valuePass);

        delete valuePass;
    }
}

void Window::setDPI             (const float& value) {

    if (_dpi != value) {
        
        _dpi = value;

        auto valuePass = new float(value);
        _windowDriver->process(WindowDriverMessages::sizeChanged, valuePass);

        delete valuePass;
    }
}

void Window::setTitle           (const std::u16string& value) {


}

void Window::setWindowState     (const unsigned& value) {

}

void Window::send               (WindowDriverMessages message, void* data) {

}
