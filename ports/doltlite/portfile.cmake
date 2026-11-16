vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/dolthub/doltlite/releases/download/v${VERSION}/doltlite-amalgamation-${VERSION}.zip"
    FILENAME "doltlite-amalgamation-${VERSION}.zip"
    SHA512 4a9c67f597e9f7192da27d659f73610c585deb37b956cdc8d3541f6e7841ed4027a26154e3899a652821d61fe6007c91d873b809c57d4e645cc96b3197e0390f
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
    SHA512 125811787822c678b1ced016031545547a089e16f566a4b2cf819ba136a0a6f571d45d46340cc47c1ece6df00edb5fc0e35b083ad4eddfc382fb6e4b85a6cd9b
    HEAD_REF master
)

vcpkg_install_copyright(FILE_LIST "${LICENSE_PATH}/APACHE_LICENSE")
