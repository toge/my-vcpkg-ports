set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 48883ddf8a6febb385a809d8bddab0fd5d0ed3d2
    SHA512 635b8f373d835723d67db0c62bfce1444a2231729aa2d7f4129fbf94643387052af3638eaa1fb0a5ff7d161f3680ccf42933d578e0169bcd868ff4fae7ef492b
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    enum    ENABLE_ENUM
    util    BUILD_UTIL
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_EXAMPLE=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/injamm")
vcpkg_cmake_config_fixup(PACKAGE_NAME injamm-sqlite3 CONFIG_PATH "lib/cmake/injamm-sqlite3")

# When the enum feature is disabled, the installed injammConfig.cmake contains
# a dead "if(OFF) ... endif()" block with add_library(enchantum::enchantum ...).
# vcpkg's heuristic usage-message scanner picks up that add_library() text and
# incorrectly advertises enchantum::enchantum in the usage instructions even
# though it is not needed. Strip the entire dead block to fix this.
if(NOT "enum" IN_LIST FEATURES)
    set(_injamm_config "${CURRENT_PACKAGES_DIR}/share/injamm/injammConfig.cmake")
    if(EXISTS "${_injamm_config}")
        file(READ "${_injamm_config}" _config_contents)
        string(REPLACE "\n" ";" _config_lines "${_config_contents}")
        set(_filtered_lines "")
        set(_skip FALSE)
        set(_depth 0)
        foreach(_line IN LISTS _config_lines)
            string(STRIP "${_line}" _stripped)
            if(_stripped STREQUAL "if(OFF)" AND NOT _skip)
                set(_skip TRUE)
                set(_depth 0)
                continue()
            endif()
            if(_skip)
                if(_stripped MATCHES "^if\\(")
                    math(EXPR _depth "${_depth} + 1")
                endif()
                if(_stripped STREQUAL "endif()")
                    if(_depth EQUAL 0)
                        set(_skip FALSE)
                        continue()
                    endif()
                    math(EXPR _depth "${_depth} - 1")
                    continue()
                endif()
                continue()
            endif()
            list(APPEND _filtered_lines "${_line}")
        endforeach()
        string(REPLACE ";" "\n" _filtered_contents "${_filtered_lines}")
        file(WRITE "${_injamm_config}" "${_filtered_contents}")
    endif()
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
