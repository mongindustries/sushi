#pragma once

#include "../core/rect.h"
#include "../core/str-methods.h"
#include "../core/pointer-ownership.h"

#include "window.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct ma_application;

/**
 * Creates a temaki window.
 *
 * @param application The application context.
 * @param title The title of the window.
 * @param location The initial position for the window.
 * @return A SU_PSTRONG to a te_window, returns NULL on failure.
 */
SU_PSTRONG(struct te_window)    te_make_window              (SU_PREF(struct ma_application) application, SU_PREF(struct su_string) title, struct su_rect location);

void                            te_kill_window              (SU_PREF(struct ma_application) application, SU_PMUT(struct te_window) window);


void                            te_window_set_position      (SU_PREF(struct te_window) window, struct su_rect value);

void                            te_window_set_title         (SU_PREF(struct te_window) window, SU_PREF(struct su_string) value);

/**
 * Method to send a window event to the application thread.
 *
 * Typical usage for this method is when you want to send an event that is not originating from the window nor
 * application thread. Example, setting the window title from a child thread of the window thread.
 *
 * @param window The target window for the message.
 * @param message The message to send.
 * @param data The data associated with the message.
 */
void                            te_window_send_message      (SU_PREF(struct te_window) window, enum te_window_event_messages message, SU_PREF(void) data);

/**
 * Method to send an application event to the window thread.
 *
 * Typical usage for this method is when an applicaiton wants to send an event to the window thread.
 * Usually you won't be using this method unless you're implementing temaki platform code.
 *
 * This method is called usually inside the `wndproc` method for Windows API or the various UIKit
 * methods for view management in iOS.
 *
 * @param window The target window for the message.
 * @param message The message to dispatch.
 * @param data The data associated with the message.
 */
void                            te_window_dispatch_message  (SU_PREF(struct te_window) window, enum te_window_event_messages message, SU_PREF(void) data);


#ifdef __cplusplus
}
#endif // __cplusplus
