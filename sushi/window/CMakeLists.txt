cmake_minimum_required      (VERSION 3.0)

project                     (sushi_window)

add_library                 (sushi_wnd  src/window.cpp
        src/windowLogic.cpp)
target_include_directories  (sushi_wnd PRIVATE ../)
