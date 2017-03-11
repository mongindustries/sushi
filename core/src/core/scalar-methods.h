#pragma once

#include "scalar.h"

// construction

struct su_scalar2   su_make_scalar2     (float x, float y);

struct su_scalar3   su_make_scalar3     (float x, float y, float z);

struct su_scalar4   su_make_scalar4     (float x, float y, float z, float w);

// expansion

struct su_scalar2   su_expand1to2       (su_scalar1 value);

struct su_scalar3   su_expand1to3       (su_scalar1 value);

struct su_scalar4   su_expand1to4       (su_scalar1 value);


struct su_scalar3   su_expand2to3       (struct su_scalar2 value);

struct su_scalar4   su_expand2to4       (struct su_scalar2 value);


struct su_scalar4   su_expand3to4       (struct su_scalar3 value);

// arithmetic

struct su_scalar4   su_multiply4        (struct su_scalar4 lhs, struct su_scalar4 rhs);
