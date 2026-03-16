#header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rlogiacco/CircularBuffer
    REF "${VERSION}"
    SHA512 ac1b82d5c8af7a9e6ffe8a639fb78a88c1fe79639a822c7a87724541e9174dc8a01230c10ad14e300fc77c324c875bda8a4e3eb543781036fe8d490219cf5347
    HEAD_REF master
)

file(COPY 
    "${SOURCE_PATH}/CircularBuffer.h"
    "${SOURCE_PATH}/CircularBuffer.hpp"
    "${SOURCE_PATH}/CircularBuffer.tpp"
    DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

