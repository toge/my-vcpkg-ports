cmake_minimum_required(VERSION 3.10)
project(doltlite C)

find_package(ZLIB REQUIRED)
find_package(Threads REQUIRED)

option(DOLTLITE_SQLITE3_COMPAT "Provide sqlite3.h for drop-in compatibility" OFF)

add_library(doltlite doltlite.c)

target_compile_definitions(doltlite PRIVATE
    SQLITE_ENABLE_COLUMN_METADATA=1
    SQLITE_ENABLE_FTS3=1
    SQLITE_ENABLE_FTS3_PARENTHESIS=1
    SQLITE_ENABLE_FTS4=1
    SQLITE_ENABLE_FTS5=1
    SQLITE_ENABLE_RTREE=1
    SQLITE_ENABLE_GEOPOLY=1
    SQLITE_ENABLE_STMTVTAB=1
    SQLITE_ENABLE_DBPAGE_VTAB=1
    SQLITE_ENABLE_DBSTAT_VTAB=1
    SQLITE_ENABLE_BYTECODE_VTAB=1
    SQLITE_ENABLE_CARRAY=1
    SQLITE_ENABLE_MATH_FUNCTIONS=1
    SQLITE_ENABLE_PERCENTILE=1
    SQLITE_MAX_TRIGGER_DEPTH=100
    SQLITE_THREADSAFE=1
    SQLITE_USE_URI=1
)

if(WIN32)
    target_compile_definitions(doltlite PRIVATE SQLITE_OS_WIN=1 _CRT_SECURE_NO_WARNINGS)
endif()

target_include_directories(doltlite PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}> $<INSTALL_INTERFACE:include>)
target_link_libraries(doltlite PRIVATE ZLIB::ZLIB Threads::Threads)
if(UNIX AND NOT APPLE)
    target_link_libraries(doltlite PRIVATE dl)
endif()

install(TARGETS doltlite
    EXPORT unofficial-doltlite-targets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(EXPORT unofficial-doltlite-targets
    NAMESPACE unofficial::doltlite::
    DESTINATION share/unofficial-doltlite
)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/unofficial-doltlite-config.cmake"
[[
include(CMakeFindDependencyMacro)
find_dependency(ZLIB)
find_dependency(Threads)
include("${CMAKE_CURRENT_LIST_DIR}/unofficial-doltlite-targets.cmake")
]])

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/unofficial-doltlite-config.cmake" DESTINATION share/unofficial-doltlite)

install(FILES doltlite.h DESTINATION include)

if(DOLTLITE_SQLITE3_COMPAT)
    # Provide sqlite3.h as well for drop-in compatibility
    configure_file(doltlite.h sqlite3.h COPYONLY)
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/sqlite3.h DESTINATION include)
endif()
