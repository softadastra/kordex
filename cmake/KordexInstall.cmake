#  @file KordexInstall.cmake
#  @author Softadastra
#
#  Copyright 2026, Softadastra. All rights reserved.
#  https://github.com/softadastra/kordex
#  Use of this source code is governed by a MIT license
#  that can be found in the LICENSE file.
#
# ====================================================================
# Kordex - Umbrella Install
# ====================================================================

include_guard(GLOBAL)

set(KORDEX_INSTALL_INCLUDED ON)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# --------------------------------------------------------------------
# Install Kordex executable
# --------------------------------------------------------------------
if(TARGET kordex)
  install(
      TARGETS kordex
      RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")
endif()

# --------------------------------------------------------------------
# Install project metadata
# --------------------------------------------------------------------
install(
    FILES
      "${CMAKE_CURRENT_SOURCE_DIR}/README.md"
      "${CMAKE_CURRENT_SOURCE_DIR}/CHANGELOG.md"
      "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE"
    DESTINATION
      "${CMAKE_INSTALL_DATADIR}/kordex")

# --------------------------------------------------------------------
# Package config
# --------------------------------------------------------------------
set(KORDEX_PACKAGE_CONFIG_IN
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/KordexConfig.cmake.in")

set(KORDEX_PACKAGE_CONFIG_OUT
    "${CMAKE_CURRENT_BINARY_DIR}/kordexConfig.cmake")

set(KORDEX_PACKAGE_VERSION_OUT
    "${CMAKE_CURRENT_BINARY_DIR}/kordexConfigVersion.cmake")

if(EXISTS "${KORDEX_PACKAGE_CONFIG_IN}")
  configure_package_config_file(
      "${KORDEX_PACKAGE_CONFIG_IN}"
      "${KORDEX_PACKAGE_CONFIG_OUT}"
      INSTALL_DESTINATION
        "${CMAKE_INSTALL_LIBDIR}/cmake/kordex")

  write_basic_package_version_file(
      "${KORDEX_PACKAGE_VERSION_OUT}"
      VERSION
        "${PROJECT_VERSION}"
      COMPATIBILITY
        SameMajorVersion)

  install(
      FILES
        "${KORDEX_PACKAGE_CONFIG_OUT}"
        "${KORDEX_PACKAGE_VERSION_OUT}"
      DESTINATION
        "${CMAKE_INSTALL_LIBDIR}/cmake/kordex")
endif()

# --------------------------------------------------------------------
# Install summary
# --------------------------------------------------------------------
message(STATUS "")
message(STATUS "Kordex install configuration")
message(STATUS "  prefix    : ${CMAKE_INSTALL_PREFIX}")
message(STATUS "  bindir    : ${CMAKE_INSTALL_BINDIR}")
message(STATUS "  libdir    : ${CMAKE_INSTALL_LIBDIR}")
message(STATUS "  includedir: ${CMAKE_INSTALL_INCLUDEDIR}")
message(STATUS "")
