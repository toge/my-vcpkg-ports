set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm
    REF 59ede4374184d9b494ecc77931a6b6fe39c892e6
    SHA512 29a80ccb5fe3b09f2bd85ee45e447c01c153aabf751d7d645f10c38b95469c113f61196d369042b409a75acd1474e43cb77f928eb6d2efc46df2fdada6dadc66
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
