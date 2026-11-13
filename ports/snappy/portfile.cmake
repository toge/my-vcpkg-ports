vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/snappy
    REF ${VERSION}
    SHA512 315c7f02dedc35be50c85e4dcc14fd1c6ed3f0bbb387cdd935b1c2f489739cb35d3124f39e09a4072306a238b1cbe13011fa02ab9e9a3196088046d6d4b18186
    HEAD_REF master
    PATCHES
        no-werror.patch
        pkgconfig.diff
        rtti.diff
        snappy-include-immintrin.patch
)
file(COPY "${CURRENT_PORT_DIR}/snappy.pc.in" DESTINATION "${SOURCE_PATH}")

vcpkg_check_features(OUT_FEATURE_OPTIONS options
    FEATURES
        rtti    SNAPPY_WITH_RTTI
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${options}
        -DSNAPPY_BUILD_TESTS=OFF
        -DSNAPPY_BUILD_BENCHMARKS=OFF

        # These variables can be overriden in a custom triplet, see usage file
        -DSNAPPY_HAVE_SSSE3=OFF
        -DSNAPPY_HAVE_X86_CRC32=OFF
        -DSNAPPY_HAVE_NEON_CRC32=OFF
        -DSNAPPY_HAVE_BMI2=OFF
        -DSNAPPY_HAVE_NEON=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/Snappy)
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")