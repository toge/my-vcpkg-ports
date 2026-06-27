set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF badd0881bbe293667009051c7c4a962af6e90db7
    SHA512 e6c848076f353db9d66616d2e377537f9ed549935e566217f57511248d520c0f055b9e3ac7f762fb7a63bfe565d335465e0c67f240cf707121a57c4b3704c21c
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        sqlite ENABLE_EXT_SQLITE3
        enum   ENABLE_ENUM
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
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
