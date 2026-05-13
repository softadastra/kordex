#  @file CMakeLists.txt
#  @author Gaspard Kirira
#
#  Copyright 2026, Gaspard Kirira. All rights reserved.
#  https://github.com/kordexjs/kordex
#  Use of this source code is governed by a MIT license
#  that can be found in the LICENSE file.
#
# ====================================================================
# Kordex
# ====================================================================

cmake_minimum_required(VERSION 3.24)

project(kordex
    VERSION 0.1.0
    DESCRIPTION "A JavaScript runtime for reliable local-first applications"
    LANGUAGES C CXX)

# --------------------------------------------------------------------
# Global C++ settings
# --------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# --------------------------------------------------------------------
# Global C++ settings
# --------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# --------------------------------------------------------------------
# Output directories
# --------------------------------------------------------------------
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
    "${CMAKE_BINARY_DIR}/lib")

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
    "${CMAKE_BINARY_DIR}/lib")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
    "${CMAKE_BINARY_DIR}/bin")

foreach(config DEBUG RELEASE RELWITHDEBINFO MINSIZEREL)
  string(TOUPPER "${config}" config_upper)

  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${config_upper}
      "${CMAKE_BINARY_DIR}/lib")

  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${config_upper}
      "${CMAKE_BINARY_DIR}/lib")

  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${config_upper}
      "${CMAKE_BINARY_DIR}/bin")
endforeach()

# --------------------------------------------------------------------
# Project paths
# --------------------------------------------------------------------
list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# --------------------------------------------------------------------
# Project paths
# --------------------------------------------------------------------
list(APPEND CMAKE_MODULE_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# --------------------------------------------------------------------
# Umbrella options
# --------------------------------------------------------------------
include(KordexOptions)

# --------------------------------------------------------------------
# Dependencies
# --------------------------------------------------------------------
include(KordexDependencies)

# --------------------------------------------------------------------
# Modules
# --------------------------------------------------------------------
include(KordexModules)

# --------------------------------------------------------------------
# Umbrella target
# --------------------------------------------------------------------
add_library(kordex_umbrella INTERFACE)
add_library(kordex::kordex ALIAS kordex_umbrella)

target_compile_features(kordex_umbrella
    INTERFACE
      cxx_std_20)

set_target_properties(kordex_umbrella PROPERTIES
    EXPORT_NAME kordex)

if(TARGET kordex::runtime)
  target_link_libraries(kordex_umbrella
      INTERFACE
        kordex::runtime)
endif()

if(TARGET kordex::bindings)
  target_link_libraries(kordex_umbrella
      INTERFACE
        kordex::bindings)
endif()

if(TARGET kordex::std)
  target_link_libraries(kordex_umbrella
      INTERFACE
        kordex::std)
endif()

if(TARGET kordex::cli)
  target_link_libraries(kordex_umbrella
      INTERFACE
        kordex::cli)
endif()

# --------------------------------------------------------------------
# Tests
# --------------------------------------------------------------------
if(KORDEX_BUILD_TESTS)
  include(CTest)
  enable_testing()
endif()

# --------------------------------------------------------------------
# Install
# --------------------------------------------------------------------
if(KORDEX_ENABLE_INSTALL)
  include(KordexInstall)
endif()

# --------------------------------------------------------------------
# Build summary
# --------------------------------------------------------------------
message(STATUS "")
message(STATUS "Kordex")
message(STATUS "  version        : ${PROJECT_VERSION}")
message(STATUS "  target         : kordex::kordex")
message(STATUS "  internal target: kordex_umbrella")
message(STATUS "  executable     : kordex")
message(STATUS "  compiler       : ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "  build          : ${CMAKE_BUILD_TYPE}")
message(STATUS "")
message(STATUS "Kordex build options")
message(STATUS "  runtime        : ${KORDEX_BUILD_RUNTIME}")
message(STATUS "  bindings       : ${KORDEX_BUILD_BINDINGS}")
message(STATUS "  std            : ${KORDEX_BUILD_STD}")
message(STATUS "  cli            : ${KORDEX_BUILD_CLI}")
message(STATUS "  app            : ${KORDEX_BUILD_APP}")
message(STATUS "  tests          : ${KORDEX_BUILD_TESTS}")
message(STATUS "  examples       : ${KORDEX_BUILD_EXAMPLES}")
message(STATUS "  warnings       : ${KORDEX_ENABLE_WARNINGS}")
message(STATUS "  sanitizers     : ${KORDEX_ENABLE_SANITIZERS}")
message(STATUS "  install        : ${KORDEX_ENABLE_INSTALL}")
message(STATUS "")
message(STATUS "Kordex umbrella configuration complete")
message(STATUS "")
