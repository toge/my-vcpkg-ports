vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lottiepp
    REF 6f7e6218d7cb240d5e39b6bad809cc48d459249c
    SHA512 ab9bf24dbacd22d8c74c60e58d32294f3f4f4e2e77885e3d7814d1db7959dffca852091b28c6b79ffdcd7eaae950f811356ddfc0b2e5adc928a12a504c293229
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_CLI=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/lottiepp")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
