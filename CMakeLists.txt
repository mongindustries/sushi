cmake_minimum_required  (VERSION 3.7)
project                 (sushi)

message                 (STATUS "CMAKE_SOURCE_DIR" ${CMAKE_SOURCE_DIR})

set                     (LIBRARY_OUTPUT_DIRECTORY   ${CMAKE_SOURCE_DIR}/lib)

include                 (${CMAKE_SOURCE_DIR}/conanbuildinfo.cmake)
conan_basic_setup       ()

include_directories     (src)

set                     (SRC_SHI_CORE   src/core/scalar-methods.c
                                        src/core/matrix-methods.c
                                        src/core/str-methods.c
                                        )

# make library

add_library             (sushi_core ${SRC_SHI_CORE})
target_link_libraries   (sushi_core ${CONAN_LIBS})
