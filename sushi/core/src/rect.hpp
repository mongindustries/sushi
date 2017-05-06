//
// Created by Michael Ong on 7/5/17.
//

#pragma once

#include "vector.hpp"

#define RECT_TYPE_TRAIT(Type)   static_assert(std::is_copy_constructible<Type>::value, "Type must be copy constructible!"); \
                                static_assert(std::is_move_constructible<Type>::value, "Type must be move constructible!");

namespace sushi { namespace core {

    template<typename Type>
    class rect {

        RECT_TYPE_TRAIT(Type)

    public:

        vector2<Type> location;

        vector2<Type> size;
    };

    template<typename Type>
    class rec_bounded {

        RECT_TYPE_TRAIT(Type)

    public:

        Type left;
        Type top;
        Type right;
        Type bottom;
    };
}}
