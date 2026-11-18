set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 08c53362cb86d8801ada89461a86c92a2240ee7d
    SHA512 8fe9967613f5e20f08974fbc90692d8a297cb5fc5bcba2a3e8d6c1e2352ef1c3e1136e99c97f38abe9b792cb84f82adab3724b53847b179b866cb2a4eef64ae4
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
