cmake_minimum_required  (VERSION 3.0)

add_definitions         (-D_UNICODE -DUNICODE)

set                     (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

add_subdirectory        (./core         ./su_core   )

add_subdirectory        (./application  ./su_app    )
add_subdirectory        (./window       ./su_wnd    )
