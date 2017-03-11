#pragma once

#include "vector.h"

struct su_rect {

    su_vector2 size;
    su_vector2 location;
};

struct su_rect_edge {

    su_scalar1 left;
    su_scalar1 top;
    su_scalar1 right;
    su_scalar1 bottom;
};
