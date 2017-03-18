#include "window-methods.h"
#include "window.h"

#include "../application/application.h"
#include "../application/application-methods.h"

#include <uv.h>

#include <stdlib.h>
#include <stdbool.h>

void                            window_event            (uv_async_t* handle) {

    SU_PSTRONG(struct te_window_event) event = (SU_PSTRONG(struct te_window_event)) handle->data;

    while (event != NULL) {

        // process event



        SU_PSTRONG(struct te_window_event) toDelete = event;
        event = toDelete->toNext;

        free(toDelete);
        toDelete = NULL;
    }
}

void                            window_thread           (void* args) {

    SU_PSTRONG(struct te_window) window = (SU_PSTRONG(struct te_window)) args;

    uv_loop_init    (&window->threadLoop);

    uv_async_init   (&window->threadLoop, &window->dispatch_windowEvents, window_event);

    uv_run          (&window->threadLoop, UV_RUN_DEFAULT);
    uv_loop_close   (&window->threadLoop);
}

void                            generate_event          (SU_PREF(struct te_window) window, enum te_window_event_messages message, void* param) {

    SU_PSTRONG(struct te_window_event) event = (SU_PSTRONG(struct te_window_event)) malloc(sizeof(struct te_window_event));

    event->ref_window   = window;

    event->event        = message;
    event->paramLow     = param;

    event->toNext       = NULL;

    if (window->dispatch_windowEvents.data == NULL) {

        window->dispatch_windowEvents.data = event;
    }
    else {

        ((SU_PWEAK(struct te_window_event)) window->dispatch_windowEvents.data)->toNext = event;
    }
}


SU_PSTRONG(struct te_window)    te_make_window          (SU_PREF(struct ma_application) application, SU_PREF(struct su_string) title, struct su_rect location) {

    SU_PWEAK    (struct te_window_driver)   driver      = application->drivers.window_driver;
    SU_PSTRONG  (struct te_window)          newWindow   = (SU_PSTRONG(struct te_window)) malloc(sizeof(struct te_window));

    newWindow->ref_application              = application;
    newWindow->driver                       = driver;

    newWindow->title                        = title;
    newWindow->position                     = location;

    newWindow->dispatch_windowEvents.data   = NULL;

    // init libuv thread for this window

    uv_mutex_init       (&newWindow->locker_windowEvents);
    uv_thread_create    (&newWindow->thread, window_thread, newWindow);

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

    uv_mutex_lock(&window->locker_windowEvents);

    SU_PSTRONG(struct su_rect) pval = (SU_PSTRONG(struct su_rect)) malloc(sizeof(struct su_rect));
    memcpy(pval, &value, sizeof(struct su_rect));

    generate_event(window, te_window_event_message_resized, pval);

    uv_mutex_unlock(&window->locker_windowEvents);

    uv_async_send(&window->dispatch_windowEvents);
}

void                            te_window_set_title     (SU_PREF(struct te_window) window, SU_PREF(struct su_string) value) {

    window->title = value;

    uv_mutex_lock(&window->locker_windowEvents);

    generate_event(window, te_window_event_message_changeTitle, su_copy_string(value));

    uv_mutex_unlock(&window->locker_windowEvents);

    uv_async_send(&window->dispatch_windowEvents);
}
