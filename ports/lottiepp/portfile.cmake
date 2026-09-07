vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lottiepp
    REF 0144cb5f5384a7a17004985f81c6bfabdb459d4b
    SHA512 8ddb2b082878c6f554243c05477a8911390ad3e5dd76dc61b29cd77c1a202c560c747fd67dba1826b07346e254e8e6e72cc7988d6cfdd284a40dfaf1e59d09d2
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
