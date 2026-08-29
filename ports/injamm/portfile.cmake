set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF caed3b6e08cc450b84b186c18d9ce08e88827f73
    SHA512 ea1d32f2c49b4736f0a19313db22fa5de815c34d56d3addb31adc4f12bebb8e7c6d49ba3a42a8f3179d540735e131ca4810e5340daab75a1dc34af2abfd4e152
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
        # Remove if(OFF) ... endif() block containing enchantum (handles nested if)
        string(REGEX REPLACE "if\\(OFF\\)[^\n]*\n([^\n]*\n)*?[ ]*endif\\(\\)[^\n]*\n" "" _injamm_contents "${_injamm_contents}")
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
