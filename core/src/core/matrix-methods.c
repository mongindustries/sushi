#include "matrix-methods.h"
#include "scalar-methods.h"

struct su_matrix44  su_mult_matrix44_from   (struct su_matrix44 lhs, struct su_matrix44 rhs) {

    struct su_matrix44 mat;

    mat.elements[0] = su_multiply4(lhs.elements[0], rhs.elements[0]);
    mat.elements[1] = su_multiply4(lhs.elements[1], rhs.elements[1]);
    mat.elements[2] = su_multiply4(lhs.elements[2], rhs.elements[2]);
    mat.elements[3] = su_multiply4(lhs.elements[3], rhs.elements[3]);

    return mat;
}

struct su_matrix44  su_make_matrix44_ident  () {

    struct su_matrix44 mat;

    mat.elements[0] = su_make_scalar4(1, 0, 0, 0);
    mat.elements[1] = su_make_scalar4(0, 1, 0, 0);
    mat.elements[2] = su_make_scalar4(0, 0, 1, 0);
    mat.elements[3] = su_make_scalar4(0, 0, 0, 1);

    return mat;
}
