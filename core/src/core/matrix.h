#pragma once

#include "scalar.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct su_matrix33 { struct su_scalar3 elements[3]; };

struct su_matrix44 { struct su_scalar4 elements[4]; };

#ifdef __cplusplus
}
#endif // __cplusplus
