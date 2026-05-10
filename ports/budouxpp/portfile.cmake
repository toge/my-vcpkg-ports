set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/budouxpp
    REF b1826bf8c6776e862c95b4940e04873e123f5fb8
    SHA512 0e55ce1adb8d62537f193ab9e4a0679756b1c67bdcb894fe47ce1f0b3444f6dfc027a4ad8adad93e768d41476e394e5543fc44b2c03f22349b51be495d952f02
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/budouxpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
