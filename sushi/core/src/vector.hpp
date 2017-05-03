#pragma once

#include "define.h"

#include <type_traits>

#define VECTOR_TYPE_TRAIT(Type) static_assert(std::is_copy_constructible<Type>::value, "Type must be copy constructible!"); \
                                static_assert(std::is_move_constructible<Type>::value, "Type must be move constructible!");

namespace sushi { namespace core {

template<typename Type>
class vector2 final {

    VECTOR_TYPE_TRAIT(Type)

public:

    Type x;
    Type y;
};

template<typename Type>
class vector3 final {

    VECTOR_TYPE_TRAIT(Type)

public:

    Type x;
    Type y;
    Type z;
};

template<typename Type>
class vector4 final {

    VECTOR_TYPE_TRAIT(Type)

public:

    Type x;
    Type y;
    Type z;
    Type w;
};

}}
