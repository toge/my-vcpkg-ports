cmake_minimum_required(VERSION 3.25)
project(fpng LANGUAGES CXX)
set(PROJECT_VERSION ${PROJECT_VERSION_STRING})
option(SSE "SSE 4.1 support" FALSE)

add_library(fpng STATIC src/fpng.cpp)
add_library(fpng::fpng ALIAS fpng)
target_include_directories(
    fpng
    PRIVATE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:include>
)

set_target_properties(fpng PROPERTIES PUBLIC_HEADER "src/fpng.h")

if (SSE)
    target_compile_definitions(fpng PRIVATE -DFPNG_NO_SSE=0)
    target_compile_options(fpng PRIVATE -msse4.1 -mpclmul)
else()
    target_compile_definitions(fpng PRIVATE -DFPNG_NO_SSE=1)
endif()

include(GNUInstallDirs)
install(TARGETS fpng
        EXPORT fpngTargets
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Create and install package files
include(CMakePackageConfigHelpers)
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/unofficial-fpngConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/unofficial-fpngConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/unofficial-fpng
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/unofficial-fpngConfigVersion.cmake
    COMPATIBILITY SameMajorVersion
)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/unofficial-fpngConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/unofficial-fpngConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/unofficial-fpng
)

# Export Targets and install that to unofficial-fpngTargets.cmake
install(
    EXPORT fpngTargets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/unofficial-fpng
    NAMESPACE unofficial::fpng::
    FILE unofficial-fpngTargets.cmake
)
