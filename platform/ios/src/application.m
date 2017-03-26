//
//  application.m
//  platform
//
//  Created by Michael Ong on 26/3/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#import "application.h"

void                            application_loop                (SU_PREF(struct ma_application) application) {

    char* argString = "";

    (void) UIApplicationMain(0, &argString, nil, NSStringFromClass([maki_application class]));
}

void                            application_init                (SU_PREF(struct ma_application) application, SU_PREF(void) customData) {

    // we don't do anything here...
}

void                            application_kill                (SU_PREF(struct ma_application) application) {


}


struct  ma_application_driver   platform_ios_create_driver_app  () {

    struct ma_application_driver driver;

    driver.initialize   = application_init;
    driver.destroy      = application_kill;

    driver.loop         = application_loop;

    return driver;
}

@implementation maki_application

- (void) applicationDidFinishLaunching: (UIApplication*) application {


}

- (void) applicationWillTerminate:      (UIApplication*) application {


}

@end
