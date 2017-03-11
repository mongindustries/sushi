#pragma once

#include "../core/rect.h"
#include "../core/str-methods.h"
#include "../core/pointer-ownership.h"

struct te_window;
struct ma_application;

SU_PSTRONG(struct te_window)    te_make_window          (SU_PREF(struct ma_application) application, SU_PREF(struct su_string) title, struct su_rect location);

void                            te_kill_window          (SU_PREF(struct ma_application) application, SU_PMUT(struct te_window) window);


void                            te_window_set_position  (SU_PREF(struct te_window) window, struct su_rect value);

void                            te_window_set_title     (SU_PREF(struct te_window) window, SU_PREF(struct su_string) value);


void                            te_window_send_message  (SU_PREF(struct te_window) window, unsigned int message, SU_PREF(void) data);
