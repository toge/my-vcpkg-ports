set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/zxcpp
    REF 6f24582ad930536759d8af81c9739fb9e749ed6f
    SHA512 6437eb7dd37c3ae3ec33e1f8b27fde6c42195d3c547591ad79a49c7301b3708f03425e7b5c892b98ca2a2e58de23175f2d3fb154afd9373d23ded74e34e6a92c
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
   OPTIONS
        -DBUILD_TEST=OFF
 )

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/zxcpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
