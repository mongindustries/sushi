cmake_minimum_required  (VERSION 3.6)
project                 (sushi_app_windows)

add_subdirectory        (../../platform/windows ./platform)

set                     (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/app/windows)

include_directories     (src ../../platform/windows/src ../../core/src)

set                     (SRC_TEST   src/application.cpp
                                    )

add_executable          (sushi_app_windows WIN32 ${SRC_TEST})
