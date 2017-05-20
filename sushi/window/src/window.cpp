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


SU_SYN_PROP                                                 (sushi::wnd::window, shared_ptr<windowLogic>,       logic)

SU_SYN_PROP_RO                                              (sushi::wnd::window, shared_ptr<void>,              inputDispatcher)

SU_SYN_PROP_RO                                              (sushi::wnd::window, unique_ptr<windowSwapChain>,   graphicsSurface)

SU_SYN_PROP_RO                                              (sushi::wnd::window, unique_ptr<windowDriver>,      driver)


SU_SYN_PROP_RO                                              (sushi::wnd::window, bool,  active)

SU_SYN_PROP_RO                                              (sushi::wnd::window, bool,  hidden)

SU_SYN_PROP_RO                                              (sushi::wnd::window, float, dpi)


void                    window::set_title                   (const u32string& value) {

    title = value;

    driver->message (shared_from_this(), windowDriver::message_titleChanged, nullptr);
}

const u32string&        window::get_title                   () const {

    return title;
}


void                    window::set_bounds                  (const core::wndw_rect_sint &value) {

    bounds = value;

    driver->message (shared_from_this(), windowDriver::message_sizeChanged, nullptr);
}

const wndw_rect_sint&   window::get_bounds                  () const {

    return bounds;
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

    bounds      = newSize;
    dpi         = newDpi;

    dirtyBounds = true;
}

void                    window::activeChanged               (bool value) {

    active                  = value;
    dirtyActivationState    = true;
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

        if (self->dirtyBounds) {

            // TODO: change the swapchain here.

            logic->contentRectChanged(self->bounds);

            self->dirtyBounds = false;
        }

        if (self->dirtyActivationState) {

            if (self->active)   { logic->didBecomeActive    (); }
            else                { logic->willBecomeInactive (); }

            self->dirtyActivationState = false;

            // TODO: place condition variable here to stall this thread.
        }

        terminate       = !logic->step();

    } while (!terminate);

    logic->destroy();
}
