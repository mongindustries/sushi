#pragma once

#include "scalar.h"

// construction

struct shi_scalar2 shi_make_scalar2     (float x, float y);

struct shi_scalar3 shi_make_scalar3     (float x, float y, float z);

struct shi_scalar4 shi_make_scalar4     (float x, float y, float z, float w);

// expansion

struct shi_scalar2 shi_expand1to2       (shi_scalar1 value);

struct shi_scalar3 shi_expand1to3       (shi_scalar1 value);

struct shi_scalar4 shi_expand1to4       (shi_scalar1 value);


struct shi_scalar3 shi_expand2to3       (struct shi_scalar2 value);

struct shi_scalar4 shi_expand2to4       (struct shi_scalar2 value);


struct shi_scalar4 shi_expand3to4       (struct shi_scalar3 value);
