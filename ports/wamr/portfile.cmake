vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO bytecodealliance/wasm-micro-runtime
    REF WAMR-${VERSION}
    SHA512 3aadee3befdd9a8f4fb45c13800e98145ef5492843b08715d9d6787dc9261fb345cc9005d9544efb184f53c83dfe495c176d97b0f05c729db76069f3e3aea60e
    HEAD_REF main
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        aot             WAMR_BUILD_AOT
        fast-jit        WAMR_BUILD_FAST_JIT
    INVERTED_FEATURES
        classic-interp  WAMR_BUILD_FAST_INTERP
)

if(VCPKG_TARGET_IS_WINDOWS AND "fast-jit" IN_LIST FEATURES)
    message(WARNING "wamr[fast-jit] is not supported on Windows - upstream forces WAMR_BUILD_FAST_JIT=0")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DWAMR_BUILD_INTERP=1
        -DWAMR_BUILD_FAST_INTERP=1
        -DWAMR_BUILD_AOT=0
        -DWAMR_BUILD_JIT=0
        -DWAMR_BUILD_FAST_JIT=0
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME iwasm CONFIG_PATH lib/cmake/iwasm)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
                    "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
