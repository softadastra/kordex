#  @file KordexInstall.cmake
#  @author Gaspard Kirira
#
#  Copyright 2026, Gaspard Kirira. All rights reserved.
#  https://github.com/kordexjs/kordex
#  Use of this source code is governed by a MIT license
#  that can be found in the LICENSE file.
#
# ====================================================================
# Kordex - Umbrella Install
# ====================================================================

set(KORDEX_INSTALL_INCLUDED ON)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

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
# Install umbrella cmake helpers
# --------------------------------------------------------------------
install(
    DIRECTORY
      "${CMAKE_CURRENT_SOURCE_DIR}/cmake/"
    DESTINATION
      "${CMAKE_INSTALL_LIBDIR}/cmake/kordex"
    FILES_MATCHING
      PATTERN "*.cmake"
      PATTERN "*.cmake.in" EXCLUDE)

# --------------------------------------------------------------------
# Optional umbrella package config
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
# Install convenience aliases file
# --------------------------------------------------------------------
set(KORDEX_ALIASES_FILE
    "${CMAKE_CURRENT_BINARY_DIR}/KordexTargets.cmake")

file(WRITE
    "${KORDEX_ALIASES_FILE}"
    "# Kordex umbrella target aliases\n")

if(TARGET kordex::runtime)
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "if(NOT TARGET Kordex::Runtime AND TARGET kordex::runtime)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  add_library(Kordex::Runtime INTERFACE IMPORTED)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  target_link_libraries(Kordex::Runtime INTERFACE kordex::runtime)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "endif()\n\n")
endif()

if(TARGET kordex::bindings)
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "if(NOT TARGET Kordex::Bindings AND TARGET kordex::bindings)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  add_library(Kordex::Bindings INTERFACE IMPORTED)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  target_link_libraries(Kordex::Bindings INTERFACE kordex::bindings)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "endif()\n\n")
endif()

if(TARGET kordex::std)
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "if(NOT TARGET Kordex::Std AND TARGET kordex::std)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  add_library(Kordex::Std INTERFACE IMPORTED)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  target_link_libraries(Kordex::Std INTERFACE kordex::std)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "endif()\n\n")
endif()

if(TARGET kordex::cli)
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "if(NOT TARGET Kordex::Cli AND TARGET kordex::cli)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  add_library(Kordex::Cli INTERFACE IMPORTED)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "  target_link_libraries(Kordex::Cli INTERFACE kordex::cli)\n")
  file(APPEND
      "${KORDEX_ALIASES_FILE}"
      "endif()\n\n")
endif()

install(
    FILES
      "${KORDEX_ALIASES_FILE}"
    DESTINATION
      "${CMAKE_INSTALL_LIBDIR}/cmake/kordex")

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
