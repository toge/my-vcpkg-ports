set(VCPKG_BUILD_TYPE release) # header only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO toge/injamm-sqlite3
    REF 8c57d9b1360f9681531c81c7ef764a374a5d5ce0
    SHA512 a267670b12f02e7ec1be038c267db15c0c7b262bc726f731f8e2868a672926ee8168c8c3d083431e7b73c804c1b932b352de7c65e3abd654635170cff697721c
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TEST=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "share/injamm-sqlite3")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
