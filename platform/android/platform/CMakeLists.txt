cmake_minimum_required      (VERSION 3.0)

project                     (sushi_platform_android)

add_library                 (sushi_platform_android application.cpp)

target_include_directories  (sushi_platform_android PRIVATE
                                                    ${PROJECT_DIR}/../../../sushi/)
