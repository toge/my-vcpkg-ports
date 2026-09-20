set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF a4fa2a69d8aa29b726903fe466608daa7ac533df
    SHA512 b35df315438629189e8f20c401f74c672281ecc088f084cf44aa12a549cab9c5e6510d0533ddf6a965e59d69ff6463ccd208c9e0aa467b4f9a7365e75b152c72
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
