#include "applicaiton.h"

void                            platform_win_application_initialize (SU_PREF(struct ma_application) application, SU_PREF(void) customData) {

    
}


struct ma_application_driver    platform_win_create_driver          () {

    struct ma_application_driver driver;

    driver.initialize = platform_win_application_initialize;

    return driver;
}
