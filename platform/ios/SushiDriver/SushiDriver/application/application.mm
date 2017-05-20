//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import "application.h"
#import "ApplicationViewController.h"

using namespace sushi::app;

void iosApplicationDriver::initialize   (sushi::app::application* const application, void* const data) const {

    // bridge data back to uhh UIApplication?

    auto    window                      = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            window.rootViewController   = [[ApplicationViewController alloc] initWithNibName:nil bundle:nil];

    [window makeKeyAndVisible];

    auto    windowRef                   = (__bridge_retained void*) window;
    this->__windowRef                   = windowRef;
}

void iosApplicationDriver::destroy      (sushi::app::application* const application) const {

    CFRelease(this->__windowRef);
}

void iosApplicationDriver::run          (sushi::app::application* const application) const {

    // do nothing. IOS does the rest.
}
