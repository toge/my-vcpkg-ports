vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rayokota/jsonata-cpp
    REF v${VERSION}
    SHA512 8fde461d3f9e8b3e68c82d2683e1eccfb5a16add0406381867ee687bd2e0fa938a3a10974e4a8b356d2b636d86c550d0e3e773e2e182c0e27177ee79b8f16242
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
