#include "window-methods.h"
#include "window.h"

#include "../application/application.h"
#include "../application/application-methods.h"

#include <stdlib.h>

SU_PSTRONG(struct te_window)    te_make_window          (SU_PREF(struct ma_application) application, SU_PREF(struct su_string) title, struct su_rect location) {

    SU_PWEAK    (struct te_window_driver)   driver      = application->drivers.window_driver;
    SU_PSTRONG  (struct te_window)          newWindow   = (SU_PSTRONG(struct te_window)) malloc(sizeof(struct te_window));

    newWindow->ref_application  = application;
    newWindow->driver           = driver;

    newWindow->title            = title;
    newWindow->position         = location;

    if (driver->initialize != NULL) {

        driver->initialize(newWindow);
    }

    return newWindow;
}


void                            te_window_set_position  (SU_PREF(struct te_window) window, struct su_rect value) {

    window->position = value;

    // TODO: send message to window backend.
}

void                            te_window_set_title     (SU_PREF(struct te_window) window, SU_PREF(struct su_string) value) {

    window->title = value;

    // TODO: send message to window backend.
}
