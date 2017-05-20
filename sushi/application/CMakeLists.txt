cmake_minimum_required      (VERSION 3.0)

project                     (sushi_application)

add_library                 (sushi_app src/application.cpp src/applicationGraphicsDevice.cpp src/applicationGraphicsDevice.hpp)
target_include_directories  (sushi_app PRIVATE ../)
