vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rayokota/jsonata-cpp
    REF v${VERSION}
    SHA512 1ce5e905652baac7b73d8d2a8f5be070ebc669a44153c1651f1ac97026c81f5dddeff6db275564abfdb442bfe324cf64d0f7bca16ba5508051fd45d381c46f63
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
