#pragma once

#include "matrix.h"
#include "vector.h"

struct shi_matrix44 shi_mult_matrix44_from  (struct shi_matrix44 rhs);


struct shi_matrix44 shi_make_matrix44_ident ();


struct shi_matrix44 shi_make_matrix44_ortho ();

struct shi_matrix44 shi_make_matrix44_persp ();


struct shi_matrix44 shi_make_matrix44_trans (shi_vector3 by);

struct shi_matrix44 shi_make_matrix44_scale (shi_vector3 by);

struct shi_matrix44 shi_make_matrix44_rotat (shi_vector3 by);

struct shi_matrix44 shi_make_matrix44_shear ();
