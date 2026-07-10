vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO MeshInspector/MeshLib
    REF v${VERSION}
    SHA512 0410b07132fa7313c3a92ea01ee7ec6f88eb9bc0fad798a71244a5ce6ff65d89d4ef97c08a702b12861473ba8419fd52f936246a75550e7c9d0852a207c443bc
    HEAD_REF master
    PATCHES
        disable-warning-as-error.patch
        use-vcpkg-deps.patch
        fix-exported-include-dirs.patch
        fix-iosfwd.patch
        fix-iterator_debug_level.patch
        fix-include.patch
)

vcpkg_find_acquire_program(PKGCONFIG)
set(ENV{PKG_CONFIG} "${PKGCONFIG}")

# meshlib supports only dynamic linking
set(VCPKG_LIBRARY_LINKAGE dynamic)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        -DMESHLIB_USE_VCPKG=ON
        -DBUILD_TESTING=OFF
        -DMR_CXX_STANDARD=20
        -DMR_PCH=OFF
        -DMESHLIB_PYTHON_SUPPORT=OFF
        -DMESHLIB_BUILD_MRCUDA=OFF
        -DMESHLIB_BUILD_MESHVIEWER=OFF
        -DMESHLIB_BUILD_MRVIEWER=OFF
        -DMESHLIB_BUILD_PYTHON_MODULES=OFF
        -DMESHLIB_USE_VCPKG=ON
        -DMRMESH_NO_GTEST=ON
)

vcpkg_cmake_install()

vcpkg_fixup_pkgconfig()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/MeshLib)

vcpkg_copy_tools(
    TOOL_NAMES meshconv
    AUTO_CLEAN
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
