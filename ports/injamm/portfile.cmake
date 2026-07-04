set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 274ff8a6c6a56d2688f521b324d2b8b92a7ef462
    SHA512 0d525bc3db5a926f042b6bbee7e766576e93775eeacd3743f3eccf8cc1587f9fb704c3a3b1f7ec3e02f4f30dbbb86bc506db403102471928509c9cf9f03bedd9
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
