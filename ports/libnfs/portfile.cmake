vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO sahlberg/libnfs
    REF "libnfs-${VERSION}"
    SHA512 59e26c1131370482b8da0eba54da54c6270a8c9f683bd7ad74a95ff06a7fc9fd744ff60c04bb3d44d6278acb6e57b3f7f0d4825e6e8f53c9e216dd000cd1c001
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
