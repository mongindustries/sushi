#pragma once

#include "../core/pointer-ownership.h"
#include "../core/pointer-attribute.h"

#include <uv.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct te_window;
struct ma_application;

struct na_input_driver {

    void    (*initialize)   (SU_PREF(struct ma_application) application, SU_PREF(struct te_window) window);

    void    (*kill)         (SU_PREF(struct ma_application) application, SU_PREF(struct te_window) window);
};

struct na_input {


};

#ifdef __cplusplus
}
#endif // __cplusplus
