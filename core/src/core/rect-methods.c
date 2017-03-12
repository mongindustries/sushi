#include "rect-methods.h"
#include "scalar-methods.h"

struct su_rect  su_make_rect(su_scalar1 x, su_scalar1 y, su_scalar1 width, su_scalar1 height) {

    struct su_rect rect;

    rect.location   .x = x;
    rect.location   .y = y;

    rect.size       .x = width;
    rect.size       .y = height;

    return rect;
}
