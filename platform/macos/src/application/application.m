#import "application.h"

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

void                            app_initialize              (SU_PREF(struct ma_application) application, SU_PREF(void) customData) {

    NSWindow* theWindow = (__bridge_transfer NSWindow*) customData;
}

void                            app_destroy                 (SU_PREF(struct ma_application) application) {


}


struct ma_application_driver    platform_win_create_driver  () {

    struct ma_application_driver driver;

    driver.initialize   = app_initialize;
    driver.destroy      = app_destroy;

    return driver;
}
