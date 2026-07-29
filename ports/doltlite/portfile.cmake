vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/dolthub/doltlite/releases/download/v${VERSION}/doltlite-amalgamation-${VERSION}.zip"
    FILENAME "doltlite-amalgamation-${VERSION}.zip"
    SHA512 7784ade039b5961442537dfccbb623ad332cce87868a42517d15eef86c6d9de015266a6e63766ef7da547a6c67edfef0e3214f382c4bbade4ea1d4670b03cee1
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
    SHA512 f8f5bb04c78f84e5aca5ed452448ccf218d06df0b1b174949b3992c41a6808a60210bf692244ce1571174f1343daf6f235f324ab641d37f885b9f556495b084f
    HEAD_REF master
)

vcpkg_install_copyright(FILE_LIST "${LICENSE_PATH}/APACHE_LICENSE")
