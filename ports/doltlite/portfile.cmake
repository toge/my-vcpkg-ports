vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/dolthub/doltlite/releases/download/v${VERSION}/doltlite-amalgamation-${VERSION}.zip"
    FILENAME "doltlite-amalgamation-${VERSION}.zip"
    SHA512 9208a479dcb75d15ab0cdd9987f14960f8d0c825fdb4603bba9706058d0fd7e02098525082c9be68f8c59976f71371b47cc7a2dba8a2a01a81fafd390ed1b17c
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
    SHA512 dcb44d5407f4a5721f496d77ef7384c131e6136114fa8de1e17288477e8577e1db059abaa62989490591016631e9e6d3ae7bdaa85d18e962389e2be002c8c6f4
    HEAD_REF master
)

vcpkg_install_copyright(FILE_LIST "${LICENSE_PATH}/APACHE_LICENSE")
