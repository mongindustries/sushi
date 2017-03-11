cmake_minimum_required  (VERSION 3.7)
project                 (sushi)

set                     (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ../lib)

message                 (STATUS "CMAKE_SOURCE_DIR: " ${CMAKE_SOURCE_DIR})
message                 (STATUS "CMAKE_ARCHIVE_OUTPUT_DIRECTORY: " ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

include_directories     (src)

# SUSHI core

set                     (SRC_SU_CORE            src/core/scalar-methods.c
                                                src/core/matrix-methods.c
                                                src/core/str-methods.c
                                                )

add_library             (sushi_core             ${SRC_SU_CORE})

# SUSHI application

set                     (SRC_SU_APCN            src/application/application-methods.c
                                                )

add_library             (sushi_application      ${SRC_SU_APCN})

# SUSHI window

set                     (SRC_SU_WIND            src/window/window-methods.c
                                                )

add_library             (sushi_window           ${SRC_SU_WIND})
