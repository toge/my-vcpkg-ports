vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/yase-json
    REF 2f0302b255edc4ccb802e1ca90a744b4e5aa83fe
    SHA512 f423c658dad4653840390adc17389fe5215b9deb793c6a0b919f37e50999402bba86ff34ed04f8f9eddb8a0f85e1752f6856cb6e0b48bceb862e9e65de2fb171
    HEAD_REF main
)

set(VCPKG_BUILD_TYPE release) # header-only port

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/yase-json)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
