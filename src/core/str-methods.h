#pragma once

#include <stdbool.h>

#include "str.h"
#include "pointer-ownership.h"

struct shi_string   shi_make_string (char* c_string);

void                shi_kill_string (SHI_PREF(struct shi_string) string);


SHI_P_HAZARD char*  shi_conv_string (SHI_PREF(struct shi_string) string);


struct shi_string   shi_join_string (SHI_PMUT(struct shi_string) lhs, SHI_PMUT(struct shi_string) rhs, bool destroy);
