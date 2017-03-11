#pragma once

#include "../core/rect.h"
#include "../core/str-methods.h"
#include "../core/pointer-ownership.h"

struct ma_application;
struct ma_application_driver;

struct te_window;

struct na_input;

struct te_window_driver {

    void                                (*initialize)   (SU_PREF(struct te_window));

    void                                (*destroy)      (SU_PREF(struct te_window));


    void                                (*dispatch)     (SU_PREF(struct te_window), unsigned int message, SU_PREF(void) data);
};

struct te_window {

    SU_PSTRONG(struct su_string)        title;

    struct su_rect                      position;


    SU_PWEAK(struct te_window_driver)   driver;

    SU_PWEAK(struct ma_application)     ref_application;


    SU_PSTRONG(void)                    thread;


    SU_PSTRONG(void)                    customData;


    SU_PSTRONG(void)                    scope_graphics;

    SU_PSTRONG(void)                    scope_sound;


    SU_PSTRONG(struct na_input)         dispatch_input;
};
