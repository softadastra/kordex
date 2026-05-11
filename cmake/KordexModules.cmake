#  @file KordexModules.cmake
#  @author Softadastra
#
#  Copyright 2026, Softadastra. All rights reserved.
#  https://github.com/softadastra/kordex
#  Use of this source code is governed by a MIT license
#  that can be found in the LICENSE file.
#
# ====================================================================
# Kordex - Umbrella Modules
# ====================================================================

include_guard(GLOBAL)

set(KORDEX_MODULES_INCLUDED ON)

# --------------------------------------------------------------------
# Module paths
# --------------------------------------------------------------------
set(KORDEX_RUNTIME_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/modules/runtime")

set(KORDEX_BINDINGS_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/modules/bindings")

set(KORDEX_STD_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/modules/std")

set(KORDEX_CLI_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/modules/cli")

# --------------------------------------------------------------------
# Helper
# --------------------------------------------------------------------
function(kordex_add_module module_name module_dir target_name)
  if(TARGET ${target_name})
    message(STATUS "Kordex module '${module_name}' already available as ${target_name}")
    return()
  endif()

  if(NOT EXISTS "${module_dir}/CMakeLists.txt")
    message(FATAL_ERROR
        "Kordex module '${module_name}' is missing CMakeLists.txt at: ${module_dir}")
  endif()

  message(STATUS "Adding Kordex module: ${module_name}")

  add_subdirectory(
      "${module_dir}"
      "${CMAKE_CURRENT_BINARY_DIR}/modules/${module_name}")

  if(NOT TARGET ${target_name})
    message(FATAL_ERROR
        "Kordex module '${module_name}' did not define required target '${target_name}'")
  endif()
endfunction()

# --------------------------------------------------------------------
# Runtime
# --------------------------------------------------------------------
if(KORDEX_BUILD_RUNTIME)
  kordex_add_module(
      runtime
      "${KORDEX_RUNTIME_DIR}"
      kordex::runtime)
endif()

# --------------------------------------------------------------------
# Bindings
# --------------------------------------------------------------------
if(KORDEX_BUILD_BINDINGS)
  if(NOT TARGET kordex::runtime)
    message(FATAL_ERROR
        "kordex::bindings requires kordex::runtime. Enable KORDEX_BUILD_RUNTIME first.")
  endif()

  kordex_add_module(
      bindings
      "${KORDEX_BINDINGS_DIR}"
      kordex::bindings)
endif()

# --------------------------------------------------------------------
# Std
# --------------------------------------------------------------------
if(KORDEX_BUILD_STD)
  if(NOT TARGET kordex::runtime)
    message(FATAL_ERROR
        "kordex::std requires kordex::runtime. Enable KORDEX_BUILD_RUNTIME first.")
  endif()

  if(NOT TARGET kordex::bindings)
    message(FATAL_ERROR
        "kordex::std requires kordex::bindings. Enable KORDEX_BUILD_BINDINGS first.")
  endif()

  kordex_add_module(
      std
      "${KORDEX_STD_DIR}"
      kordex::std)
endif()

# --------------------------------------------------------------------
# CLI
# --------------------------------------------------------------------
if(KORDEX_BUILD_CLI)
  if(NOT TARGET kordex::runtime)
    message(FATAL_ERROR
        "kordex::cli requires kordex::runtime. Enable KORDEX_BUILD_RUNTIME first.")
  endif()

  if(NOT TARGET kordex::bindings)
    message(FATAL_ERROR
        "kordex::cli requires kordex::bindings. Enable KORDEX_BUILD_BINDINGS first.")
  endif()

  if(NOT TARGET kordex::std)
    message(FATAL_ERROR
        "kordex::cli requires kordex::std. Enable KORDEX_BUILD_STD first.")
  endif()

  kordex_add_module(
      cli
      "${KORDEX_CLI_DIR}"
      kordex::cli)
endif()

# --------------------------------------------------------------------
# Summary
# --------------------------------------------------------------------
message(STATUS "")
message(STATUS "Kordex umbrella modules")
message(STATUS "  runtime  : ${KORDEX_BUILD_RUNTIME}")
message(STATUS "  bindings : ${KORDEX_BUILD_BINDINGS}")
message(STATUS "  std      : ${KORDEX_BUILD_STD}")
message(STATUS "  cli      : ${KORDEX_BUILD_CLI}")
message(STATUS "")
