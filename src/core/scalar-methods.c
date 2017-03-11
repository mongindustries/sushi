#include "scalar-methods.h"

struct shi_scalar2 shi_make_scalar2     (float x, float y) {

    struct shi_scalar2 p; p.x = x; p.y = y;
    return p;
}

struct shi_scalar3 shi_make_scalar3     (float x, float y, float z) {

    struct shi_scalar3 p; p.x = x; p.y = y; p.z = z;
    return p;
}

struct shi_scalar4 shi_make_scalar4     (float x, float y, float z, float w) {

    struct shi_scalar4 p; p.x = x; p.y = y; p.z = z; p.w = w;
    return p;
}


struct shi_scalar2 shi_expand1to2       (shi_scalar1 value) {

    return shi_make_scalar2(value, 0);
}

struct shi_scalar3 shi_expand1to3       (shi_scalar1 value) {

    return shi_make_scalar3(value, 0, 0);
}

struct shi_scalar4 shi_expand1to4       (shi_scalar1 value) {

    return shi_make_scalar4(value, 0, 0, 0);
}


struct shi_scalar3 shi_expand2to3       (struct shi_scalar2 value) {

    return shi_make_scalar3(value.x, value.y, 0);
}

struct shi_scalar4 shi_expand2to4       (struct shi_scalar2 value) {

    return shi_make_scalar4(value.x, value.y, 0, 0);
}


struct shi_scalar4 shi_expand3to4       (struct shi_scalar3 value) {

    return shi_make_scalar4(value.x, value.y, value.z, 0);
}
