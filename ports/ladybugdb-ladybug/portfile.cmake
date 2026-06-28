vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO LadybugDB/ladybug
    REF v${VERSION}
    SHA512 5b1df1ef939970e2d85c72dc421d2f60dca5ba667d5a9a9dca80500a36b5cf95c839e2736a6df74ff136d43836e402a10cd0b25a8229cc78e62991b932614ed2
    HEAD_REF master
    PATCHES
        unofficial-cmake-config.patch
        include-cstdint.patch
        fix-alp-encode-avx512.patch
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        shell BUILD_SHELL
)

if(VCPKG_TARGET_IS_LINUX AND VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    # binutils 2.46 ld.bfd の -z separate-code 既定で .init セクションが
    # 非実行セグメントに配置され _init シンボルと不整合となり、ローダが
    # DT_INIT を呼んだ時点で SIGSEGV する問題を回避する。
    set(EXTRA_LINKER_FLAGS "-DCMAKE_SHARED_LINKER_FLAGS=-Wl,-z,noseparate-code")
else()
    set(EXTRA_LINKER_FLAGS "")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DBUILD_SINGLE_FILE_HEADER=OFF
        -DBUILD_TESTS=FALSE
        ${EXTRA_LINKER_FLAGS}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME unofficial-ladybugdb-ladybug
    CONFIG_PATH share/unofficial-ladybugdb-ladybug
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
