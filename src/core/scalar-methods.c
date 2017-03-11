#include "scalar-methods.h"

struct su_scalar2 su_make_scalar2     (float x, float y) {

    struct su_scalar2 p; p.x = x; p.y = y;
    return p;
}

struct su_scalar3 su_make_scalar3     (float x, float y, float z) {

    struct su_scalar3 p; p.x = x; p.y = y; p.z = z;
    return p;
}

struct su_scalar4 su_make_scalar4     (float x, float y, float z, float w) {

    struct su_scalar4 p; p.x = x; p.y = y; p.z = z; p.w = w;
    return p;
}


struct su_scalar2 su_expand1to2       (su_scalar1 value) {

    return su_make_scalar2(value, 0);
}

struct su_scalar3 su_expand1to3       (su_scalar1 value) {

    return su_make_scalar3(value, 0, 0);
}

struct su_scalar4 su_expand1to4       (su_scalar1 value) {

    return su_make_scalar4(value, 0, 0, 0);
}


struct su_scalar3 su_expand2to3       (struct su_scalar2 value) {

    return su_make_scalar3(value.x, value.y, 0);
}

struct su_scalar4 su_expand2to4       (struct su_scalar2 value) {

    return su_make_scalar4(value.x, value.y, 0, 0);
}


struct su_scalar4 su_expand3to4       (struct su_scalar3 value) {

    return su_make_scalar4(value.x, value.y, value.z, 0);
}
