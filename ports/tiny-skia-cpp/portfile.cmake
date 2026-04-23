vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jwmcglynn/tiny-skia-cpp
    REF 4a4452684411d82e4fd123c5bc5919754c7e11fa
    SHA512 cfa67c8827b1176870133acc96e3a57d1a64b9d8882142f72eec32a6ecca284e06e16bca59242f2ff81a408a8990670ced1c2120eface5d993bae89d876bc28a
    PATCHES
        fix-cmake.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DTINY_SKIA_BUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH share/unofficial-tiny-skia-cpp PACKAGE_NAME unofficial-tiny-skia-cpp)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/include/tiny_skia/path64/tests"
    "${CURRENT_PACKAGES_DIR}/include/tiny_skia/pipeline/tests"
    "${CURRENT_PACKAGES_DIR}/include/tiny_skia/scan/tests"
    "${CURRENT_PACKAGES_DIR}/include/tiny_skia/shaders/tests"
    "${CURRENT_PACKAGES_DIR}/include/tiny_skia/wide/tests"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
