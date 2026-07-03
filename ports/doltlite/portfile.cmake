vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/dolthub/doltlite/releases/download/v${VERSION}/doltlite-amalgamation-${VERSION}.zip"
    FILENAME "doltlite-amalgamation-${VERSION}.zip"
    SHA512 150aba0f4ff0d07d7faf631c37b326064f87b7c83a16693d17fb5da912fcb1bfb63ed063b55881d8a99c63e4f671735cdbcb5fef6d2b878d1e71c06a6623800e
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
    SHA512 cc44d6bc4b141c2b3a293252785e4a95fd7192bb7afa0cd933746a5785481fbf0494457c0e1060bec295f608010232982f13bd9e3e720acb8e4a690d50cea067
    HEAD_REF master
)

vcpkg_install_copyright(FILE_LIST "${LICENSE_PATH}/APACHE_LICENSE")
