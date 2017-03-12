#include "str-methods.h"
#include "str.h"

#include <stdlib.h>
#include <string.h>

SU_PSTRONG(struct su_string)    su_make_string (const char* c_string) {

    // OBJECTIVE: expand c_string into su_string.

    unsigned int        head_idx            = 0;
    unsigned int        length              = (unsigned long) strlen(c_string);

    SU_PSTRONG(struct su_string)  thestring = calloc(1, sizeof(struct su_string));

    thestring->_data    = (unsigned int*) calloc(length, sizeof(unsigned int));

    thestring->_size    = length;
    thestring->_hash    = 0;

    while (head_idx < length) {

        thestring->_data[head_idx] = (unsigned int) c_string[head_idx];

        head_idx += 1;
    }

    return thestring;
}

void                            su_kill_string (SU_PMUT(struct su_string) string) {

    free(string->_data);

    string->_data   = NULL;

    string->_size   = 0;
    string->_hash   = 0;

    free(string);

    string          = NULL;
}


char*                           su_conv_string (SU_PREF(struct su_string) string) {

    unsigned char*      c_string    = (unsigned char*) calloc(string->_size + 1, sizeof(char));

    unsigned int        head_idx    = 0;
    unsigned int        length      = string->_size;

    while (head_idx < length) {

        c_string[head_idx] = (char)string->_data[head_idx];
        head_idx += 1;
    }

    c_string[head_idx] = '\0';

    return  c_string;
}


SU_PSTRONG(struct su_string)    su_join_string (SU_PMUT(struct su_string) lhs, SU_PMUT(struct su_string) rhs, bool destroy) {

    unsigned int        head_idx                = 0;
    unsigned int        length                  = lhs->_size + rhs->_size;

    SU_PSTRONG(struct su_string)  new_string  = malloc(sizeof(struct su_string));

    new_string->_data   = (unsigned int*) calloc(length, sizeof(unsigned int));

    new_string->_size   = lhs->_size + rhs->_size;
    new_string->_hash   = 0;

    (void) memcpy(new_string->_data,                lhs->_data, lhs->_size);
    (void) memcpy(new_string->_data + lhs->_size,   rhs->_data, rhs->_size);

    if (destroy == true) {

        su_kill_string(lhs); lhs = NULL;
        su_kill_string(rhs); rhs = NULL;
    }

    return new_string;
}

bool                            su_comp_string (SU_PREF(struct su_string) lhs, SU_PREF(struct su_string) rhs) {
    
    if (lhs->_size != rhs->_size) { return false; }

    return memcmp(lhs->_data, rhs->_data, lhs->_size) == 0;
}
