vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ArthurSonzogni/RTXUI
  REF "v${VERSION}"
  SHA512 e0f7ec46f7f8af0d6af2b73ef64106e92cead272e3b8ce71a0dc5da7b586b7cae2700254611f31ca22471b57443b49ce67fe150a14210e47862b3c9a88ade98c
  HEAD_REF main
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DRTXUI_BUILD_TESTS=OFF
    -DRTXUI_BUILD_EXAMPLES=OFF
    -DRTXUI_BUILD_FUZZERS=OFF
    -DRTXUI_BUILD_BENCHMARKS=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME rtxui CONFIG_PATH lib/cmake/rtxui)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE
  "${CURRENT_PACKAGES_DIR}/debug/include"
  "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
