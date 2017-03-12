#pragma once

#include "matrix.h"
#include "vector.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct su_matrix44 su_mult_matrix44_from  (struct su_matrix44 lhs, struct su_matrix44 rhs);


struct su_matrix44 su_make_matrix44_ident ();


struct su_matrix44 su_make_matrix44_ortho ();

struct su_matrix44 su_make_matrix44_persp ();


struct su_matrix44 su_make_matrix44_trans (su_vector3 by);

struct su_matrix44 su_make_matrix44_scale (su_vector3 by);

struct su_matrix44 su_make_matrix44_rotat (su_vector3 by);

struct su_matrix44 su_make_matrix44_shear ();

#ifdef __cplusplus
}
#endif // __cplusplus
