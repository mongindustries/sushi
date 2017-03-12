#include "window-methods.h"
#include "window.h"

#include "../application/application.h"
#include "../application/application-methods.h"

#include <uv.h>

#include <stdlib.h>
#include <stdbool.h>

SU_PSTRONG(struct te_window)    te_make_window          (SU_PREF(struct ma_application) application, SU_PREF(struct su_string) title, struct su_rect location) {

    SU_PWEAK    (struct te_window_driver)   driver      = application->drivers.window_driver;
    SU_PSTRONG  (struct te_window)          newWindow   = (SU_PSTRONG(struct te_window)) malloc(sizeof(struct te_window));

    newWindow->ref_application  = application;
    newWindow->driver           = driver;

    newWindow->title            = title;
    newWindow->position         = location;

    if (driver->initialize != NULL) {

        driver->initialize(application, newWindow);
    }

    // add window to application window list

    bool entryEmplaced = false;

    do {

        // find nearest window entry that is NULL

        for (int i = 0; i < application->windows.count; i++) {

            struct ma_application_window_entry entry = application->windows.entries[i];

            if (entry.window == NULL) {

                entry.window    = newWindow;
                entryEmplaced   = true;

                break;
            }
        }

        if (entryEmplaced == false) {

            application->windows.count      = application->windows.count + 2;
            application->windows.entries    = (SU_PSTRONG(struct ma_application_window_entry)) calloc(application->windows.count, sizeof(struct ma_application_window_entry));
        }

    } while (entryEmplaced == false);

    return newWindow;
}

void                            te_kill_window          (SU_PREF(struct ma_application) application, SU_PMUT(struct te_window) window) {

    application->drivers.window_driver->destroy(application, window);

    window->ref_application = NULL;
    window->driver          = NULL;

    if (window->title != NULL) { free(window->title); window->title = NULL; }

    // remove window from application window list

    for (int i = 0; i < application->windows.count; i++) {

        struct ma_application_window_entry entry = application->windows.entries[i];

        if (entry.window == window) {

            entry.window = NULL;
            entry.thread = NULL;
        }
    }

    free(window);
    window = NULL;
}


void                            te_window_set_position  (SU_PREF(struct te_window) window, struct su_rect value) {

    window->position = value;

    // TODO: send message to window backend.
}

void                            te_window_set_title     (SU_PREF(struct te_window) window, SU_PREF(struct su_string) value) {

    window->title = value;

    // TODO: send message to window backend.
}
