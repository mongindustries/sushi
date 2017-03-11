cmake_minimum_required  (VERSION 3.6)
project                 (sushi_windows)

set                     (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ../lib/windows)

include_directories     (src ../../)

set                     (SRC_PLATFORM_WIN       src/application/application.c
                                                )

add_library             (sushi_platform_win     ${SRC_PLATFORM_WIN})
