// window.cpp
// sushiwindow - sushicpp
// 
// Created: 13:20 08/19/2017
// Author: Michael Ong

#include "../window.hpp"
#include "../windowLogic.hpp"
#include "../windowEncapsulationIDs.hpp"

#include <sushicore/FastFail.h>

#include <sushiapplication/application.hpp>

#include <sushigraphics/graphicsDevice.hpp>
#include <sushigraphics/graphicsSurface.hpp>

using namespace std;

using namespace sushi::core;
using namespace sushi::application;
using namespace sushi::window;

using namespace sushi::drivers;

Rectangle                   Window::undefinedRectangle  = Rectangle { glm::vec2 { 0, 0 }, glm::vec2 { -1, -1 } };


WindowEncapsulatedMessage*  Window::encapsulate         (unsigned int dataID, void* data) {

    auto message = new WindowEncapsulatedMessage();

    message->data = data;
    message->dataID = dataID;

    return message;
}


Window::Window                          (WindowDriver* driver, WindowLogic* logic):

CoreObject              (),
WindowDriverDelegate    (),

_dpi                    (0),
_title                  (u"Title Goes Here!"),
_windowState            (),

_backingWindow          (nullptr),

_windowDriver           (driver),
_graphicsSurface        (nullptr),
_inputDispatcher        (nullptr),

_windowLogic            (logic) {

    assert(_windowDriver->delegate == nullptr);

    _windowDriver   ->delegate  = this;
    _windowLogic    ->window    = this;

    _backingWindow              = _windowDriver->initalise();

    _inputDispatcher            = nullptr;
    _graphicsSurface            = Application::instance->getGraphicsDevice()->createSurface({ 1, 1 }, 1, _backingWindow);
}

Window::Window                          (const Window&& move):

_dpi                    (move._dpi),
_title                  (std::move(move._title)),
_windowState            (std::move(move._windowState)),

_backingWindow          (move._backingWindow),

_windowDriver           (move._windowDriver),
_graphicsSurface        (move._graphicsSurface),
_inputDispatcher        (move._inputDispatcher),

_windowLogic            (move._windowLogic) {

    _windowDriver->delegate = this;
    _windowLogic->window = this;
}

Window::~Window                         () {

    delete _windowLogic;
    delete _windowDriver;
}


void        Window::setLocation        (const Rectangle& value) {

    if (_location != value) {

        auto finalValue = value;

        if (finalValue == undefinedRectangle) {

            finalValue = _windowDriver->getUndefinedRect();
        }

        _location = finalValue;

        _windowDriver->process(WindowDriverMessages::sizeChanged, nullptr);
    }
}

void        Window::setDPI             (const float& value) {

    if (_dpi != value) {
        
        _dpi = value;

        _windowDriver->process(WindowDriverMessages::sizeChanged, nullptr);
    }
}

void        Window::setTitle           (const u16string& value) {

    if (_title != value) {

        _title = value;

        _windowDriver->process(WindowDriverMessages::titleChanged, nullptr);
    }
}

void        Window::setWindowState     (const set<WindowStates> &value) {

    if (_windowState != value) {

        _windowState = value;

        _windowDriver->process(WindowDriverMessages::stateChanged, nullptr);
    }
}

void        Window::send               (WindowDriverMessages message, WindowEncapsulatedMessage* data) {

    switch (message) {

        case WindowDriverMessages::sizeChanged: {

            auto resizeNeeded = false;

            if (data->dataID == WindowEncapsulationIDs::valueFloat) {

                const auto newValue = float(*reinterpret_cast<float*>(data->data));

                if (newValue != _dpi) {

                    _dpi = newValue;
                    resizeNeeded = true;
                }

            } else if (data->dataID == WindowEncapsulationIDs::valueRectangle) {

                const auto newValue = Rectangle(*reinterpret_cast<Rectangle*>(data->data));

                if (newValue != _location) {

                    _location = newValue;
                    resizeNeeded = true;
                }

            } else {

                FastFail::instance->crash(failureTypes::unexpectedPayload("(Window::send): Expecting a float or a Rectangle but got something else."));
            }

            if (resizeNeeded) {

                _graphicsSurface->resize(_location.size, _dpi);
            }

        }   break;
        case WindowDriverMessages::titleChanged:

            if (data->dataID == WindowEncapsulationIDs::valueString) {

                _title = u16string(*reinterpret_cast<u16string*>(data->data));

            } else {

                FastFail::instance->crash(failureTypes::unexpectedPayload("(Window::send): Expecting a u16string but got something else."));
            }

            break;
        case WindowDriverMessages::stateChanged:

            if (data->dataID == WindowEncapsulationIDs::valueSet) {

                _windowState = set<WindowStates>(*reinterpret_cast<set<WindowStates>*>(data->data));

            } else {

                FastFail::instance->crash(failureTypes::unexpectedPayload("(Window::send): Expecting a set<WindowStates> but got something else."));
            }

            break;
    }
}
