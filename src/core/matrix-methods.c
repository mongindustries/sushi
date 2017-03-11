#include "matrix-methods.h"
#include "scalar-methods.h"

struct shi_matrix44 shi_make_matrix44_ident() {

    struct shi_matrix44 mat;

    mat.elements[0] = shi_make_scalar4(1, 0, 0, 0);
    mat.elements[1] = shi_make_scalar4(0, 1, 0, 0);
    mat.elements[2] = shi_make_scalar4(0, 0, 1, 0);
    mat.elements[3] = shi_make_scalar4(0, 0, 0, 1);

    return mat;
}
