set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/bdfdrawpp
    REF 0bf7cd3fac62c1dd8322f6948bf0c77c0604f717
    SHA512 902c957929c92e2f1ee88132eb11d494e30431ddd98560f152a9a94dc451488d51fb0cb416a5237e819ab838380b040200e5209cfbf38d4608583c0beb72ecbd
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/bdfpp")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
