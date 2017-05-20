//
//  AppDelegate.m
//  SushiApp
//
//  Created by Michael Ong on 19/5/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#import "AppDelegate.h"

#import <application.hpp>
#import <window.hpp>

#import "application/application.h"
#import "window/window.h"

#import "AppLogic.h"

#import <memory>

using namespace std;

using namespace sushi::app;
using namespace sushi::wnd;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    auto appDriver = unique_ptr<applicationDriver>(new iosApplicationDriver());
    application::initialize(appDriver, (__bridge void*) app);

    auto wndDriver = unique_ptr<windowDriver>(new iosWindowDriver());
    window::make(wndDriver, U"I am a window!", make_shared<AppLogic>());

    application::run();

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationDidReceiveMemoryWarning:(UIApplication*)app {

    auto    delegate = application::get_instance()->get_driver()->delegate.lock();
            delegate->receivedLowMemory(application::get_instance());
}


- (void)applicationWillTerminate:(UIApplication *)application {

    application::destroy();
}

@end
