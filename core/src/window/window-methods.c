#include "window-methods.h"

#include "../application/application.h"
#include "../application/application-methods.h"

#include "../core/rect-methods.h"

#include <stdlib.h>
#include <assert.h>

// Method that handles ALL inbound messages from application thread.
void                            digest_event                (uv_async_t* handle) {

    SU_PSTRONG(struct te_window_event)  event   = (SU_PSTRONG(struct te_window_event)) handle->data;

    SU_PWEAK(struct te_window)          window  = event->ref_window;
    SU_PWEAK(struct ma_application)     app     = window->ref_application;

    uv_mutex_lock(&window->digest_locker_windowEvents);

    while (event != NULL) {

        // process event

        switch (event->event) {

        case te_window_event_message_changeTitle: {

            window->title = su_copy_string((SU_PWEAK(struct su_string)) event->paramLow);
        }   break;

        case te_window_event_message_resized: {

            SU_PWEAK(struct su_rect)prect = (SU_PWEAK(struct su_rect)) event->paramLow;

            window->position = su_make_rect(prect->location.x, prect->location.y, prect->size.x, prect->size.y);
        }   break;

        case te_window_event_message_activated:
            break;

        default:
            break;
        }

        free(event->paramLow);
        event->paramLow = NULL;

        SU_PSTRONG(struct te_window_event) toDelete = event;
        event = toDelete->toNext;

        free(toDelete);
        toDelete = NULL;
    }

    uv_mutex_unlock(&window->digest_locker_windowEvents);
}
// Method that handles ALL outbound message from window thread.
void                            dispatch_event              (uv_async_t *handle) {

    SU_PSTRONG(struct te_window_event)  event   = (SU_PSTRONG(struct te_window_event)) handle->data;

    SU_PWEAK(struct te_window)          window  = event->ref_window;
    SU_PWEAK(struct ma_application)     app     = window->ref_application;

    uv_mutex_lock(&window->dispatch_locker_windowEvents);

    while (event != NULL) {

        // process event

        window->driver->dispatch(app, window, event->event, event->paramLow);

        free(event->paramLow);
        event->paramLow = NULL;

        SU_PSTRONG(struct te_window_event) toDelete = event;
        event = toDelete->toNext;

        free(toDelete);
        toDelete = NULL;
    }

    uv_mutex_unlock(&window->dispatch_locker_windowEvents);
}

void                            window_thread               (void* args) {

    SU_PSTRONG(struct te_window)        window  = (SU_PSTRONG(struct te_window)) args;
    SU_PSTRONG(struct ma_application)   app     = window->ref_application;

    uv_loop_init    (&window->threadLoop);

    uv_async_init   (&window->threadLoop, &window->dispatch_windowEvents, dispatch_event);
    uv_async_init   (&window->threadLoop, &window->digest_windowEvents, digest_event);

    uv_run          (&window->threadLoop, UV_RUN_DEFAULT);
    uv_loop_close   (&window->threadLoop);
}


void                            generate_out_event          (SU_PREF(struct te_window) window, enum te_window_event_messages message, void *param) {

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

void                            generate_in_event           (SU_PREF(struct te_window) window, enum te_window_event_messages message, void* param) {

    SU_PSTRONG(struct te_window_event) event = (SU_PSTRONG(struct te_window_event)) malloc(sizeof(struct te_window_event));

    event->ref_window   = window;

    event->event        = message;
    event->paramLow     = param;

    event->toNext       = NULL;

    if (window->digest_windowEvents.data == NULL) {

        window->digest_windowEvents.data = event;
    }
    else {

        ((SU_PWEAK(struct te_window_event)) window->digest_windowEvents.data)->toNext = event;
    }
}


SU_PSTRONG(struct te_window)    te_make_window              (SU_PREF(struct ma_application) application, SU_PREF(struct su_string) title, struct su_rect location) {

    SU_PWEAK    (struct te_window_driver)   driver      = application->drivers.window_driver;
    SU_PSTRONG  (struct te_window)          newWindow   = (SU_PSTRONG(struct te_window)) malloc(sizeof(struct te_window));

    newWindow->ref_application              = application;
    newWindow->driver                       = driver;

    newWindow->title                        = title;
    newWindow->position                     = location;

    newWindow->dispatch_windowEvents.data   = NULL;
    newWindow->digest_windowEvents.data     = NULL;

    if (driver->initialize != NULL) {

        driver->initialize(application, newWindow);
    }

    // init libuv thread for this window

    uv_mutex_init       (&newWindow->dispatch_locker_windowEvents);
    uv_mutex_init       (&newWindow->digest_locker_windowEvents);

    uv_thread_create    (&newWindow->thread, window_thread, newWindow);

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

void                            te_kill_window              (SU_PREF(struct ma_application) application, SU_PMUT(struct te_window) window) {

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


void                            te_window_set_position      (SU_PREF(struct te_window) window, struct su_rect value) {

    SU_PSTRONG(struct su_rect) pval = (SU_PSTRONG(struct su_rect)) malloc(sizeof(struct su_rect));
    memcpy(pval, &value, sizeof(struct su_rect));

    te_window_send_message(window, te_window_event_message_resized, pval);
}

void                            te_window_set_title         (SU_PREF(struct te_window) window, SU_PREF(struct su_string) value) {

    te_window_send_message(window, te_window_event_message_changeTitle, value);
}


void                            te_window_send_message      (SU_PREF(struct te_window) window, enum te_window_event_messages message, SU_PREF(void) data) {

    uv_mutex_lock(&window->dispatch_locker_windowEvents);

    generate_out_event(window, message, data);

    uv_mutex_unlock(&window->dispatch_locker_windowEvents);

    uv_async_send(&window->dispatch_windowEvents);
}

void                            te_window_dispatch_message  (SU_PREF(struct te_window) window, enum te_window_event_messages message, SU_PREF(void) data) {

    uv_mutex_lock(&window->digest_locker_windowEvents);

    generate_in_event(window, message, data);

    uv_mutex_unlock(&window->digest_locker_windowEvents);

    uv_async_send(&window->digest_windowEvents);
}
