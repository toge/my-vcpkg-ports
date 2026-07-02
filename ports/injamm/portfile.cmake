set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 80733dc24b8f34ace2a931fca1a2504b553d599b
    SHA512 9f3041a3ffb6cd66d33b8ce7f15909d39ff6a317e2c89d8ea7c59af3ebec12de4ea7eeccee52993d8cfb209d947b9ab5fb3f0df1587c9167d29ee426fcff9a4d
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
