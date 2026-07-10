vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rayokota/jsonata-cpp
    REF v${VERSION}
    SHA512 bd4bb8db1d2c0c23bad675dccc3c25ea60b0482a01405bffadbeaf3c09d391e4913a1eebdb585697473fb039bbb56ef1b54c069ef87690a88d9c8780be491f7d
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
