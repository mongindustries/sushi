#import "application.h"

@implementation AppDelegate

- (void)                        applicationDidFinishLaunching:  (NSNotification*) notification {

}

@end

void                            app_initialize                  (SU_PREF(struct ma_application) application, SU_PREF(void) customData) {

    NSApplication* theWindow = (__bridge_transfer NSApplication*) customData;
}

void                            app_destroy                     (SU_PREF(struct ma_application) application) {


}


struct ma_application_driver    platform_mac_create_driver      () {

    struct ma_application_driver driver;

    driver.initialize   = app_initialize;
    driver.destroy      = app_destroy;

    return driver;
}
