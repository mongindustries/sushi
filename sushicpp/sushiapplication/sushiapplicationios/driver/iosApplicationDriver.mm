//
//  iosApplicationDriver.mm
//  sushiapplicationiosios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "iosApplicationDriver.hpp"

#include "../../sushiapplication/application.hpp"

#include <sushigraphicsios/driver/iosGraphicsDriver.hpp>
#include <sushiwindowios/driver/iosWindowDriver.hpp>

#import <UIKit/UIKit.h>
#import <vector>

using namespace std;

using namespace sushi::drivers;
using namespace sushi::drivers::ios;

using namespace sushi::application;

@interface          iosApplicationDriverDelegate: NSObject<UIApplicationDelegate>

@end

@implementation     iosApplicationDriverDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {

    Application::instance->getInitCallback()(Application::instance);
}

@end

// ----

iosApplicationDriver::iosApplicationDriver                  ():

graphicsDriver  (new iosGraphicsDriver()),
storageDriver   (nullptr) {

}

iosApplicationDriver::~iosApplicationDriver                 () {

    delete graphicsDriver;
}


GraphicsDriver*     iosApplicationDriver::getGraphicsDriver () const {

    return graphicsDriver;
}

void*               iosApplicationDriver::getStorageDriver  () const {

    return storageDriver;
}

WindowDriver*       iosApplicationDriver::getWindowDriver   () const {

    return new iosWindowDriver();
}


void                iosApplicationDriver::initialise        () {

    auto arguments = [[NSProcessInfo processInfo] arguments];

    auto finalArgs = vector<char*>();

    for (NSString* arg in arguments) {

        char* item = new char[arg.length + 1];
        memcpy(item, arg.UTF8String, arg.length);

        finalArgs.push_back(item);
    }

    UIApplicationMain(static_cast<int>(finalArgs.size()), finalArgs.data(), nil, NSStringFromClass([iosApplicationDriverDelegate class]));

    for_each(finalArgs.begin(), finalArgs.end(), [](auto& item) {

        delete item;
        item = nullptr;
    });
}

void                iosApplicationDriver::destroy           () {


}
