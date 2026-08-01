vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lottiepp
    REF 2f714fdac53afae176ce350b70519200bb930422
    SHA512 422e93a0ff4d3780c32417e53e9dc97d6267468e0251f00302065fd178ab23b2df1e0759d55087bc37286a6bfb44a7610a7d931f68a2e430a5d9a6db1ce90993
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
        -DBUILD_CLI=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/lottiepp")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
