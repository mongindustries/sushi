#pragma once

/**
    Sushi string. These are immutable data type that has a UTF-32 backing data.

 */
struct su_string {

    unsigned int*   _data;

    unsigned long   _size;

    unsigned long   _hash;
};
