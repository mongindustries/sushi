//
//  macosApplicationDriver.cpp
//  sushiapplicationmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "macosApplicationDriver.hpp"

#include "../../sushiapplication/application.hpp"

#include <sushigraphicsmacos/driver/macosGraphicsDriver.hpp>
#include <sushiwindowmacos/driver/macosWindowDriver.hpp>

#import <AppKit/AppKit.h>
#import <vector>

using namespace std;

using namespace sushi::drivers;
using namespace sushi::drivers::macos;

using namespace sushi::application;

@interface          macosApplicationDriverDelegate: NSObject<NSApplicationDelegate>

@end

@implementation     macosApplicationDriverDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {

    Application::instance->getInitCallback()(Application::instance);
}

@end

// ----

macosApplicationDriver::macosApplicationDriver              ():

graphicsDriver  (new macosGraphicsDriver()),
storageDriver   (nullptr) {

}

macosApplicationDriver::~macosApplicationDriver             () {

    delete graphicsDriver;
}


GraphicsDriver*     macosApplicationDriver::getGraphicsDriver () const {

    return graphicsDriver;
}

void*               macosApplicationDriver::getStorageDriver  () const {

    return storageDriver;
}

WindowDriver*       macosApplicationDriver::getWindowDriver   () const {

    return new macosWindowDriver();
}


void                macosApplicationDriver::initialise        () {

    auto arguments = [[NSProcessInfo processInfo] arguments];

    auto finalArgs = vector<const char*>();

    for (NSString* arg in arguments) {

        char* item = new char[arg.length + 1];
        memcpy(item, arg.UTF8String, arg.length);

        finalArgs.push_back(item);
    }

    NSApplicationMain(static_cast<int>(finalArgs.size()), finalArgs.data());

    for_each(finalArgs.begin(), finalArgs.end(), [](auto& item) {

        delete item;
        item = nullptr;
    });
}

void                macosApplicationDriver::destroy           () {


}
