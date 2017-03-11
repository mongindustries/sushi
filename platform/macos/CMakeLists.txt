cmake_minimum_required  (VERSION 3.6)
project                 (sushi_macos)

add_subdirectory        (../../core ./base)

set                     (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/)

include_directories     (src ../../)

set                     (SRC_PLATFORM_MAC       src/application/application.m
                                                )

add_library             (sushi_platform_mac     ${SRC_PLATFORM_MAC})
target_compile_options  (sushi_platform_mac     PUBLIC "-fobjc-arc")

add_dependencies        (sushi_platform_mac     sushi_core
                                                sushi_app
                                                sushi_window)
