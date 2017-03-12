#pragma once

#include "../core/rect.h"
#include "../core/str-methods.h"
#include "../core/pointer-ownership.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct ma_application;
struct ma_application_driver;

struct te_window;

struct na_input;

enum te_window_flags {

    te_window_flag_windowSizeFullscreen         = 0x0100,
    te_window_flag_windowSizeBorderless         ,
    te_window_flag_windowSizeRegular            ,

    te_window_flag_renderSurfaceTransparent     = 0x0200,

    te_window_flag_windowPosFreeform            = 0x0300,
    te_window_flag_windowPosCentered            ,

    te_window_flag_takesNoInput                 = 0x0400,
};

struct te_window_driver {

    void                                (*initialize)   (SU_PREF(struct ma_application), SU_PREF(struct te_window));

    void                                (*destroy)      (SU_PREF(struct ma_application), SU_PREF(struct te_window));


    void                                (*dispatch)     (SU_PREF(struct ma_application), SU_PREF(struct te_window), unsigned int message, SU_PREF(void) data);
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

#ifdef __cplusplus
}
#endif // __cplusplus
