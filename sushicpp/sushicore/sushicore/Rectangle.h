// Rectangle.h
// sushicore - sushicpp
// 
// Created: 01:15 08/15/2017
// Author: Michael Ong

#pragma once

#include "Vector.h"
#include <glm/detail/type_float.hpp>

namespace sushi::core {

struct Rectangle {

    glm::vec2           location;

    glm::vec2           size;
};

struct RectangleEdge {
    
    glm::float32        left;

    glm::float32        right;

    glm::float32        top;

    glm::float32        bottom;
};

inline Rectangle        make_rectangle  (const glm::vec2& location,
                                         const glm::vec2& size) {
    
    auto    rectangle           = Rectangle();

            rectangle.location  = location;
            rectangle.size      = size;

    return  rectangle;
}

inline RectangleEdge    make_rectangle  (const glm::float32 l, 
                                         const glm::float32 r, 
                                         const glm::float32 t, 
                                         const glm::float32 b) {
    
    auto    rectangle           = RectangleEdge();

            rectangle.left      = l;
            rectangle.right     = r;

            rectangle.top       = t;
            rectangle.bottom    = b;

    return  rectangle;
}
}