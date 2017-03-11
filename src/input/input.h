#pragma once

#include "../core/pointer-ownership.h"
#include "../core/pointer-attribute.h"

struct te_window;
struct ma_application;

struct na_input_driver {

    void(*initialize)(SU_PREF(struct ma_application) application, SU_PREF(struct te_window) window);

void(*kill)(SU_PREF(struct ma_application) application, SU_PREF(struct te_window) window);
};

struct na_input {


};
