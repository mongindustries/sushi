cmake_minimum_required      (VERSION 3.6)
project                     (sushi)

add_subdirectory            (../deps/libuv ./deps/libuv)

set                         (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/base)

message                     (STATUS "CMAKE_SOURCE_DIR: " ${CMAKE_SOURCE_DIR})
message                     (STATUS "CMAKE_ARCHIVE_OUTPUT_DIRECTORY: " ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

include_directories         (../deps/libuv/libuv/include src)

# SUSHI core

set                         (SRC_SU_CORE            src/core/scalar-methods.c
                                                    src/core/matrix-methods.c
                                                    src/core/rect-methods.c
                                                    src/core/str-methods.c
                                                    )

add_library                 (sushi_core             ${SRC_SU_CORE})
target_include_directories  (sushi_core PUBLIC      src)

# SUSHI application

set                         (SRC_SU_APCN            src/application/application-methods.c
                                                    )

add_library                 (sushi_app              ${SRC_SU_APCN})
target_include_directories  (sushi_app PUBLIC       src)

# SUSHI window

set                         (SRC_SU_WIND            src/window/window-methods.c
                                                    )

add_library                 (sushi_window           ${SRC_SU_WIND})
add_dependencies            (sushi_window           uv)

target_include_directories  (sushi_window PUBLIC    src)
