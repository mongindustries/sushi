#pragma once

#include <stdbool.h>

#include "pointer-ownership.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct su_string; // f-dec

SU_PSTRONG(struct su_string)    su_make_string  (const char* c_string);

void                            su_kill_string  (SU_PMUT(struct su_string) string);

/*
    Converts a sushi string into a c string.
    HAZARD: Usually you don't want to use this, unless necessary.
 */
SU_P_HAZARD char*              su_conv_string   (SU_PREF(struct su_string) string);


SU_PSTRONG(struct su_string)    su_join_string  (SU_PMUT(struct su_string) lhs, SU_PMUT(struct su_string) rhs, bool destroy);

bool                            su_comp_string  (SU_PREF(struct su_string) lhs, SU_PREF(struct su_string) rhs);

#ifdef __cplusplus
}
#endif // __cplusplus
