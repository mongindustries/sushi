#include "matrix-methods.h"
#include "scalar-methods.h"

struct su_matrix44 su_make_matrix44_ident() {

    struct su_matrix44 mat;

    mat.elements[0] = su_make_scalar4(1, 0, 0, 0);
    mat.elements[1] = su_make_scalar4(0, 1, 0, 0);
    mat.elements[2] = su_make_scalar4(0, 0, 1, 0);
    mat.elements[3] = su_make_scalar4(0, 0, 0, 1);

    return mat;
}
