vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/jpegli
    REF d0e83a89dffda4a9bbd04f6785cf94b614d7aa19
    SHA512 b053e32ec2342e90dd6d8b71bbbc1c0f3e3151d1c90377ea24f76a597aaaf149c44d92132d8f32b1a462cf6f9d25cfbc6de8d24c37e6922205be8a83b50e43c9
    HEAD_REF main
    PATCHES
        fix-dependencies.patch
        msvc-remove-libm.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH LIBJPEG_TURBO_SOURCE_PATH
    REPO libjpeg-turbo/libjpeg-turbo
    REF 8ecba3647edb6dd940463fedf38ca33a8e2a73d1
    SHA512 3b40c10d526350ef61e0ed804b6e33f2ba0393aa31210fd4924f4fd421b84ca842a1e6450f1bcc7a6b01cdb1d3fa11d91fe81552e73913b149a0555bfec19380
    HEAD_REF main
)
file(REMOVE_RECURSE "${SOURCE_PATH}/third_party/libjpeg-turbo")
file(COPY "${LIBJPEG_TURBO_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/libjpeg-turbo")

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        tools JPEGXL_ENABLE_TOOLS
)

if(VCPKG_TARGET_IS_UWP)
    string(APPEND VCPKG_C_FLAGS " /wd4146")
    string(APPEND VCPKG_CXX_FLAGS " /wd4146")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DJPEGXL_VERSION=${JPEGXL_VERSION}"
        -DJPEGXL_FORCE_SYSTEM_HWY=ON
        -DJPEGXL_FORCE_SYSTEM_BROTLI=ON
        -DJPEGXL_FORCE_SYSTEM_LCMS2=ON
        ${FEATURE_OPTIONS}
        -DJPEGXL_ENABLE_BENCHMARK=OFF
        -DJPEGXL_ENABLE_DOXYGEN=OFF
        -DJPEGXL_ENABLE_FUZZERS=OFF
        -DJPEGXL_ENABLE_JNI=OFF
        -DJPEGXL_ENABLE_MANPAGES=OFF
        -DJPEGXL_ENABLE_OPENEXR=OFF
        -DJPEGXL_ENABLE_SJPEG=OFF
        -DJPEGXL_ENABLE_SKCMS=OFF
        -DJPEGXL_ENABLE_TCMALLOC=OFF
        -DBUILD_TESTING=OFF
        -DCMAKE_FIND_PACKAGE_TARGETS_GLOBAL=ON
        -DJPEGXL_BUNDLE_LIBPNG=OFF
        -DJPEGXL_ENABLE_JPEGLI_LIBJPEG=ON
        -DJPEGXL_INSTALL_JPEGLI_LIBJPEG=ON
    MAYBE_UNUSED_VARIABLES
        CMAKE_DISABLE_FIND_PACKAGE_GIF
        CMAKE_DISABLE_FIND_PACKAGE_JPEG
        CMAKE_DISABLE_FIND_PACKAGE_PNG
        CMAKE_DISABLE_FIND_PACKAGE_ZLIB
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

if(JPEGXL_ENABLE_TOOLS)
    vcpkg_copy_tools(TOOL_NAMES cjpegli djpegli AUTO_CLEAN)
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/jxl/jxl_cms_export.h" "ifdef JXL_CMS_STATIC_DEFINE" "if 1")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/jxl/jxl_threads_export.h" "ifdef JXL_THREADS_STATIC_DEFINE" "if 1")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
