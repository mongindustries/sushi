//
// Created by Michael Ong on 20/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#include "AppLogic.h"

#include <window.hpp>

void AppLogic::initialize           () {

    auto lock_window = get_window().lock();
}

void AppLogic::destroy              () {

}


bool AppLogic::step                 () {

    return true;
}


void AppLogic::willBecomeInactive   () {

}

void AppLogic::didBecomeActive      () {

}


void AppLogic::contentRectChanged   (const sushi::core::wndw_rect_sint& newrect) {


}
