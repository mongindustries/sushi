cmake_minimum_required  (VERSION 3.6)
project                 (sushi_windows)

add_subdirectory        (../../core ./base)

set                     (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/)

include_directories     (src ../../)

set                     (SRC_PLATFORM_WIN       src/application/application.c
                                                src/window/window.c)

add_library             (sushi_platform_win     ${SRC_PLATFORM_WIN})
add_dependencies        (sushi_platform_win     sushi_core
                                                sushi_app
                                                sushi_window)
