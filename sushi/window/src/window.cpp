//
// Created by Michael Ong on 23/4/17.
//

#include "window.hpp"
#include "windowLogic.hpp"

#include <application/src/application.hpp>
#include <cassert>

using namespace std;

using namespace sushi::core;

using namespace sushi::wnd;
using namespace sushi::app;

int                     windowDriver::message_sizeChanged   = 0xD000'0001;

int                     windowDriver::message_titleChanged  = 0xD000'0002;


window::window                                              ():

    inputDispatcher (nullptr),
    driver          (nullptr) {

}


weak_ptr<window>        window::make                        (unique_ptr<windowDriver> &driver,
                                                             const u32string &title,
                                                             const shared_ptr<windowLogic>& logic) {

    assert  (!driver->integrated);

    auto    windowPtr                       = make_shared<window>();

            windowPtr->title                = title;

            windowPtr->driver               = move(driver);
            windowPtr->driver->integrated   = true;

            windowPtr->logic                = logic;

            windowPtr->driver->delegate     = windowPtr;

            windowPtr->driver->make         (windowPtr);

    // and then move this pointer to application

    auto    app                             = application::get_instance();

            app->bindWindow                 (windowPtr);

    // hydrate logic thread here!

            windowPtr->thread_logic         = thread(window::thread_logic_hydrater, windowPtr);

    return  windowPtr;
}


SU_SYN_PROP                                                 (window, shared_ptr<windowLogic>,   logic)

SU_SYN_PROP_RO                                              (window, shared_ptr<void>,          inputDispatcher)

SU_SYN_PROP_RO                                              (window, unique_ptr<windowDriver>,  driver)


SU_SYN_PROP_RO                                              (window, bool, active)

SU_SYN_PROP_RO                                              (window, bool, hidden)

SU_SYN_PROP_RO                                              (window, float, dpi)


void                    window::set_title                   (const u32string& value) {

    title = value;

    driver->message (shared_from_this(), windowDriver::message_titleChanged, nullptr);
}

const u32string&        window::get_title                   () const {

    return title;
}


void                    window::set_size                    (const size_vec2_sint &value) {

    size = value;

    driver->message (shared_from_this(), windowDriver::message_sizeChanged, nullptr);
}

const size_vec2_sint&   window::get_size                    () const {

    return size;
}


void                    window::show                        (const wndw_rect_sint &rect) {

    hidden = false;

    driver->state   (shared_from_this(), windowState::shown);
}

void                    window::hide                        () {

    hidden = true;

    driver->state   (shared_from_this(), windowState::hidden);
}


void                    window::close                       () {

    assert(logic != nullptr);

    thread_logic.join   ();

    auto SHARED         = shared_from_this();

    driver->message     (SHARED, 0, nullptr);

    auto app            = application::get_instance();

    driver->state       (SHARED, windowState::hidden);
    driver->kill        (SHARED);

    app->unbindWindow   (SHARED);
}


void                    window::sizeChanged                 (const wndw_rect_sint& newSize, const float& newDpi) {

    size    = newSize.size;
    dpi     = newDpi;
}

void                    window::activeChanged               (bool value) {

    active = value;
}

void                    window::terminate                   () {

    close();
}


void                    window::thread_logic_hydrater       (const shared_ptr<window>& self) {

    assert(self->logic != nullptr);

    auto&   logic       = self->logic;
    bool    terminate;

    logic->window       = self;

    logic->initialize();

    do {

        terminate       = !logic->step();

    } while (!terminate);

    logic->destory();
}
