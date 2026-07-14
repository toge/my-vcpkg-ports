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

if("symbolmesh" IN_LIST FEATURES)
  set(SYMBOLMESH_FLAG ON)
else()
  set(SYMBOLMESH_FLAG OFF)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        -DMESHLIB_USE_VCPKG=ON
        -DBUILD_TESTING=OFF
        -DMR_CXX_STANDARD=20
        -DMR_PCH=OFF
        -DMRMESH_NO_GTEST=ON
        -DMRMESH_NO_TIFF=ON
        -DCMAKE_INSTALL_INCLUDEDIR:STRING=include
        -DCMAKE_INSTALL_LIBDIR:STRING=lib
        # Build only the MRMesh core (geometry + basic I/O); drop heavy features.
        -DMESHLIB_PYTHON_SUPPORT=OFF
        -DMESHLIB_BUILD_PYTHON_MODULES=OFF
        -DMESHLIB_BUILD_MESHVIEWER=OFF
        -DMESHLIB_BUILD_MRVIEWER=OFF
        -DMESHLIB_BUILD_MESHCONV=OFF
        -DMESHLIB_BUILD_VOXELS=OFF
        -DMESHLIB_BUILD_EXTRA_IO_FORMATS=OFF
        -DMESHLIB_BUILD_MCP=OFF
        -DMESHLIB_BUILD_MRCUDA=OFF
        -DMESHLIB_BUILD_SYMBOLMESH=${SYMBOLMESH_FLAG}
)

vcpkg_cmake_install()

vcpkg_fixup_pkgconfig()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/MeshLib)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share"
                    "${CURRENT_PACKAGES_DIR}/debug/include"
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
