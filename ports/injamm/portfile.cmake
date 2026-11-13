set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 70e56cfd797514176af2a82df533cf559055337a
    SHA512 f82e35043a77b109d62d719b008a6e59463229766f42474f8547a38e41183a4a1036db3c72c3bb28fc35669433fcf98a9eace1a80adfcb2b504791181abd832b
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

# When enum feature is off, upstream installs a dead if(OFF)...endif() block
# that mentions enchantum; strip it so vcpkg usage scanner doesn't advertise it.
# ponytail: fragile line parser; upstream should guard with if(ENABLE_ENUM) instead.
if(NOT "enum" IN_LIST FEATURES)
    set(_injamm_config "${CURRENT_PACKAGES_DIR}/share/injamm/injammConfig.cmake")
    if(EXISTS "${_injamm_config}")
        file(READ "${_injamm_config}" _injamm_contents)
        # Remove if(OFF) block containing enchantum (single-line body)
        string(REGEX REPLACE "if\\(OFF\\)[^\n]*\n[^\n]*enchantum[^\n]*\n[ ]*endif\\(\\)[^\n]*\n" "" _injamm_contents "${_injamm_contents}")
        # Fallback: if regex missed, replace if(OFF) with if(FALSE) to keep it dead but not matched by scanner
        if(_injamm_contents MATCHES "if\\(OFF\\)")
            string(REPLACE "if(OFF)" "if(FALSE)" _injamm_contents "${_injamm_contents}")
        endif()
        file(WRITE "${_injamm_config}" "${_injamm_contents}")
        unset(_injamm_contents)
    endif()
    unset(_injamm_config)
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
