set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 9679e951241719e1c628c5a2146c5f8fa76439a9
    SHA512 a61a95f54e8717c0e4e3247d5af5dc47cbd714f0e89363fb974f702c80b1a40abb058c219005f1364d190d364285f6fc224f34c15d98f77f0a5f478f0b2399fe
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        sqlite ENABLE_EXT_SQLITE3
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
