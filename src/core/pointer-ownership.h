#pragma once

/*
    Denotes that the pointer returned is a strong reference.
    That is, the pointer returned will not be freed by the calling function.
    It is up to the callee to free the pointer.
 */
#define SU_PSTRONG(type) type*

/*
    Denotes that the pointer returned is a weak reference.
    Weak references shan't be freed by the calle.
 */
#define SU_PWEAK(type) type*

/*
    Denotes that the pointer being passed acts as a reference.
    No manipulation of the pointer itself will be made.

 */
#define SU_PREF(type) type* const

/*
    Denotes that the pointer being passed can be modified (or mutated).
    Use this instead to inform the calle of a function that the parameter
    might be changed after the function ends.

 */
#define SU_PMUT(type) type*

/*
    Denotes that the pointer returned MIGHT NOT be a pointer at all.
    // Special case for C-string (char arrays).

 */
#define SU_P_HAZARD
