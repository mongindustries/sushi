#include "str-methods.h"

#include <stdlib.h>
#include <string.h>

struct shi_string   shi_make_string (char* c_string) {

    // OBJECTIVE: expand c_string into shi_string.

    unsigned int        head_idx    = 0;
    unsigned int        length      = (unsigned long) strlen(c_string);

    struct shi_string   thestring;

    thestring._data     = (unsigned int*) calloc(length, sizeof(unsigned int));

    thestring._size     = length;
    thestring._hash     = 0;

    while (head_idx < length) { thestring._data[head_idx] = (unsigned int) c_string[head_idx]; head_idx += 1; }

    return thestring;
}

void                shi_kill_string (SHI_PREF(struct shi_string) string) {

    free(string->_data);

    string->_data = NULL;

    string->_size = 0;
    string->_hash = 0;
}


char*               shi_conv_string (SHI_PREF(struct shi_string) string) {

    return NULL;
}


struct shi_string   shi_join_string (SHI_PMUT(struct shi_string) lhs, SHI_PMUT(struct shi_string) rhs, bool destroy) {

    unsigned int        head_idx    = 0;
    unsigned int        length      = lhs->_size + rhs->_size;

    struct shi_string   new_string;

    new_string._data    = (unsigned int*) calloc(length, sizeof(unsigned int));

    new_string._size    = lhs->_size + rhs->_size;
    new_string._hash    = 0;

    (void) memcpy(new_string._data,                 lhs->_data, lhs->_size);
    (void) memcpy(new_string._data + lhs->_size,    rhs->_data, rhs->_size);

    if (destroy == true) {

        shi_kill_string(lhs); lhs = NULL;
        shi_kill_string(rhs); rhs = NULL;
    }

    return new_string;
}
