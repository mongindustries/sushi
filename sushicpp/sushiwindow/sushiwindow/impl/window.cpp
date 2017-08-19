// window.cpp
// sushiwindow - sushicpp
// 
// Created: 13:20 08/19/2017
// Author: Michael Ong

#include "../window.hpp"
#include "../windowLogic.hpp"

using namespace sushi::window;
using namespace sushi::drivers;


Window::Window          (WindowDriver* driver, WindowLogic* logic):

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

Window::~Window         () {

}

void Window::setLocation(const core::Rectangle& value) {
}

void Window::setDPI(const float& value) {
}

void Window::setTitle(const std::u16string& value) {
}

void Window::setWindowState(const unsigned& value) {
}

void    Window::send    (unsigned message, void* data) {
}
