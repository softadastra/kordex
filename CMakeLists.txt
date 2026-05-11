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
    LANGUAGES CXX)

# --------------------------------------------------------------------
# Global C++ settings
# --------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

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
add_library(kordex INTERFACE)
add_library(kordex::kordex ALIAS kordex)

target_compile_features(kordex
    INTERFACE
      cxx_std_20)

if(TARGET kordex::runtime)
  target_link_libraries(kordex
      INTERFACE
        kordex::runtime)
endif()

if(TARGET kordex::bindings)
  target_link_libraries(kordex
      INTERFACE
        kordex::bindings)
endif()

if(TARGET kordex::std)
  target_link_libraries(kordex
      INTERFACE
        kordex::std)
endif()

if(TARGET kordex::cli)
  target_link_libraries(kordex
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
# Install umbrella target
# --------------------------------------------------------------------
install(
    TARGETS kordex
    EXPORT kordexTargets)

install(
    EXPORT kordexTargets
    FILE kordexTargets.cmake
    NAMESPACE kordex::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/kordex")

# --------------------------------------------------------------------
# Install
# --------------------------------------------------------------------
include(KordexInstall)

# --------------------------------------------------------------------
# Build summary
# --------------------------------------------------------------------
message(STATUS "")
message(STATUS "Kordex")
message(STATUS "  version   : ${PROJECT_VERSION}")
message(STATUS "  target    : kordex::kordex")
message(STATUS "  compiler  : ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "  build     : ${CMAKE_BUILD_TYPE}")
message(STATUS "")
message(STATUS "Kordex build options")
message(STATUS "  runtime   : ${KORDEX_BUILD_RUNTIME}")
message(STATUS "  bindings  : ${KORDEX_BUILD_BINDINGS}")
message(STATUS "  std       : ${KORDEX_BUILD_STD}")
message(STATUS "  cli       : ${KORDEX_BUILD_CLI}")
message(STATUS "  app       : ${KORDEX_BUILD_APP}")
message(STATUS "  tests     : ${KORDEX_BUILD_TESTS}")
message(STATUS "  examples  : ${KORDEX_BUILD_EXAMPLES}")
message(STATUS "  warnings  : ${KORDEX_ENABLE_WARNINGS}")
message(STATUS "  sanitizers: ${KORDEX_ENABLE_SANITIZERS}")
message(STATUS "")
message(STATUS "Kordex umbrella configuration complete")
message(STATUS "")
