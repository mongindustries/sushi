cmake_minimum_required  (VERSION 3.6)
project                 (sushi_app_windows)

add_subdirectory        (../../platform/windows ./platform)

set                     (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/app/windows)
set                     (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/out/windows)

include_directories     (src ../../ ../../deps/libuv/libuv/include)

set                     (SRC_TEST   src/application.cpp
                                    )

add_executable          (sushi_app_windows  WIN32 ${SRC_TEST})

add_dependencies        (sushi_app_windows  uv

                                            sushi_core
                                            sushi_app
                                            sushi_window

                                            sushi_platform_win)

target_link_libraries   (sushi_app_windows  uv

                                            sushi_core
                                            sushi_app
                                            sushi_window

                                            sushi_platform_win)