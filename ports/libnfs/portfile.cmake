vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sahlberg/libnfs
    REF "libnfs-${VERSION}"
    SHA512 16464129a827af897af35120d8b495993ea9bc56889fa815230e6fd999f391834256a83f3b58060b4c8e0c5d0608e2ca76f3716cff05ca15c40551a2be4aa8ad
    HEAD_REF master
    PATCHES
        fix-exported-target.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS options
    FEATURES
        multithreading ENABLE_MULTITHREADING
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${options}
        -DENABLE_TESTS=OFF
        -DENABLE_DOCUMENTATION=OFF
        -DENABLE_UTILS=OFF
        -DENABLE_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME libnfs CONFIG_PATH lib/cmake/libnfs)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING" "${SOURCE_PATH}/LICENCE-BSD.txt")