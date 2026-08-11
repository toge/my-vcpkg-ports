vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO vitaut/zmij
    REF v1.1
    SHA512 7f485e2bbdbf18dad707af9746681a5a57153feac4adba4b00b3ae10dff3da360cef7b481c386f49de65b5bbe986028676dd18424897d64d31c7d1c8cdf41d43
    HEAD_REF main
    PATCHES
        CMakeLists.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DZMIJ_BUILD_EXAMPLE=OFF
        -DZMIJ_BUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/zmij)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
