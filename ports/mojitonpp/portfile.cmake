set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/mojitonpp
    REF 1a45af03e1e5493f8af2a218941992f66a705304
    SHA512 0f46ff081c8e0aaa31a6ca00fee8b41b3c4dc2c7f6e376c5b3bd26484a3df55b89504a1b2f93aa40912d88fdbb8ac663e1d77bcb537d33e70fc6a038167779b9
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/mojitonpp")

vcpkg_copy_tools(
    TOOL_NAMES sequence_detector
    AUTO_CLEAN
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
