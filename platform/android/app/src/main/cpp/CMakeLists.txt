cmake_minimum_required      (VERSION 3.4.1)

add_subdirectory            (${PROJECT_DIR}/../../../sushi  ./su)
add_subdirectory            (${PROJECT_DIR}/../platform     ./su-plat)

find_library                (log-lib log)

add_library                 (sushi_lib SHARED   ./native-lib.cpp)

target_include_directories  (sushi_lib PRIVATE
                                            ${PROJECT_DIR}/../platform
                                            ${PROJECT_DIR}/../../../sushi)

target_link_libraries       (sushi_lib      ${log-lib}
                                            sushi_app
                                            sushi_wnd
                                            sushi_platform_android)
