set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 39c38f4e1782fc494706fcfe22d29bdf68b409ca
    SHA512 e406693e03fc99f99cc3d45e63e8450569255168cd8b811ac6327877f139aea9003e0b4847d5b68deb2f8e92fcb9a413c6c9dd536dbf2df9128b60762515c0f5
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DINJAMM_BUILD_TESTS=OFF
        -DINJAMM_BUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/injamm")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
