set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/lexborpp
    REF dabea0fbb256e5e4662ace75b769b753c67ad868
    SHA512 f8ff8f64d5affba4cd1a3f25a6517e9c684e630046acd6ad49536832fe5b285dd4217f8bcfb50fb2913a9a7416d51dc1ed0a21f6eaa59689ba8809c7a111e413
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/lexborpp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
