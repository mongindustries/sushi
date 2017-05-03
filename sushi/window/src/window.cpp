//
// Created by Michael Ong on 23/4/17.
//

#include "window.hpp"

#include <application/src/application.hpp>

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


weak_ptr<window>        window::make                        (unique_ptr<windowDriver> &driver, const u32string &title) {

    auto    windowPtr                   = make_shared<window>();

            windowPtr->title            = title;

            windowPtr->driver           = move(driver);
            windowPtr->driver->delegate = windowPtr;

            windowPtr->driver->make     (windowPtr);

    // and then move this pointer to application

    auto    app                         = application::get_instance();

            app->bindWindow             (windowPtr);

    return  windowPtr;
}


SU_SYN_PROP_RO                                              (window, shared_ptr<void>,          inputDispatcher)

SU_SYN_PROP_RO                                              (window, unique_ptr<windowDriver>,  driver)


SU_SYN_PROP_RO                                              (window, float, dpi)

void                    window::set_title                   (const u32string& value) {

    title = value;

    driver->message (shared_from_this(), windowDriver::message_titleChanged, nullptr);
}

const u32string&        window::get_title                   () const {

    return title;
}


void                    window::set_size                    (const float &value) {

    size = value;

    driver->message (shared_from_this(), windowDriver::message_sizeChanged, nullptr);
}

const float&            window::get_size                    () const {

    return size;
}


void                    window::show                        (const float &rect) {

    driver->state   (shared_from_this(), windowState::shown);
}

void                    window::hide                        () {

    driver->state   (shared_from_this(), windowState::hidden);
}


void                    window::close                       () {

    auto app = application::get_instance();

    driver->state       (shared_from_this(), windowState::hidden);
    driver->kill        (shared_from_this());

    app->unbindWindow   (shared_from_this());
}


void                    window::sizeChanged                 (const float& newSize, const float& newDpi) {

    size    = newSize;
    dpi     = newDpi;
}

void                    window::activeChanged               (bool value) {

}
