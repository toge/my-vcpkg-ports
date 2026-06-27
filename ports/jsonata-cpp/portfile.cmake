vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rayokota/jsonata-cpp
    REF v${VERSION}
    SHA512 6aad513bb2bae13659b8b7eb5175f445fce3a55872edd41bced2d6e647591b1c20d7a85885bf1c6260897d90394b5b251975f20958c74bbdbcfc597a2277bd10
    HEAD_REF master
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(JSONATA_BUILD_SHARED OFF)
else()
    set(JSONATA_BUILD_SHARED ON)
endif()


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DJSONATA_BUILD_TESTS=OFF
        -DJSONATA_BUILD_SHARED=${JSONATA_BUILD_SHARED}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    CONFIG_PATH lib/cmake/jsonata
    PACKAGE_NAME jsonata
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
