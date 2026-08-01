set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 86ee8e774240c9178b1890e44ca5356c6febd03b
    SHA512 56f771b5adb99ce7a944882e12ff6c31ef7975ef4e8d704a065f485ac7ab9a1d46f8b62b5403860885a977c7619f186f0c3808fd262e1f8e3e3e900282bb8e5f
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    enum    ENABLE_ENUM
    sqlite3 ENABLE_SQLITE3
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
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
