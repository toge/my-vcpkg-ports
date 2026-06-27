vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/dolthub/doltlite/releases/download/v${VERSION}/doltlite-amalgamation-${VERSION}.zip"
    FILENAME "doltlite-amalgamation-${VERSION}.zip"
    SHA512 2c15f07c3cdf38f09776af0f37af4d6ea46eb22b92496bfc03964bb68dd880c598e7b5593bdcaff0397e7f1b29f108788e47ecd9b10354a5821fc429c1a590ca
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "sqlite3-compat" DOLTLITE_SQLITE3_COMPAT
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-doltlite)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_from_github(
    OUT_SOURCE_PATH LICENSE_PATH
    REPO dolthub/doltlite
    REF "v${VERSION}"
    SHA512 9e90c7945f06730080cfad637d46aa27c4adc1a0c4aa5b84732b22d7ec79860e9db1b26664500b2be429b02423aa8a106341a0478e6b0c659ba54cfd3391e7e5
    HEAD_REF master
)

vcpkg_install_copyright(FILE_LIST "${LICENSE_PATH}/APACHE_LICENSE")
