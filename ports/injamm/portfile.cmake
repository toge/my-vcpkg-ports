set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF bc3eb0e94f7a5a2d4930c2b34101112805e044d2
    SHA512 5bb69184f2614f5a5ac29aad3a78fad4f78990b15e8a94f4609ec0076087bcfb3d6fa69bad7fcd820c1509d81243d402be6b707e231f43a7d89db272465412c3
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
