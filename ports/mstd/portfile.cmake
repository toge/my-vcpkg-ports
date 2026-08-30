vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MAIPA01/mstd
    REF "v${VERSION}"
    SHA512 b19fa6a0eb017dd56938567de064b2673b56fdccf31de47f99fbc516ab1084a5c9fef77133ebda45079adb7aab8016524779fca9932875df2c9b050eb4c149e7
    HEAD_REF main
    PATCHES
        fix-consumer-interface.patch
        fix-missing-standard-includes.patch
)

set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DMSTD_FMT_EXTERNAL=ON
        -DMSTD_BUILD_TESTS=OFF
        -DMSTD_BUILD_COVERAGE=OFF
        -DMSTD_BUILD_DOCUMENTATION=OFF
        -DMSTD_ENABLE_CLANG_TIDY=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH cmake)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug"
    "${CURRENT_PACKAGES_DIR}/lib"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
