#  @file KordexDependencies.cmake
#  @author Gaspard Kirira
#
#  Copyright 2026, Gaspard Kirira. All rights reserved.
#  https://github.com/kordexjs/kordex
#  Use of this source code is governed by a MIT license
#  that can be found in the LICENSE file.
#
# ====================================================================
# Kordex - Umbrella Dependencies
# ====================================================================

set(KORDEX_DEPENDENCIES_INCLUDED ON)

# --------------------------------------------------------------------
# Local dependency root
# --------------------------------------------------------------------
set(KORDEX_DEPS_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/deps"
    CACHE PATH
    "Kordex local dependencies directory")

set(KORDEX_VIX_DEPS_DIR
    "${KORDEX_DEPS_DIR}/vix"
    CACHE PATH
    "Local Vix dependencies directory")

# --------------------------------------------------------------------
# Helper
# --------------------------------------------------------------------
function(kordex_add_local_dependency dependency_name dependency_dir target_name)
  if(TARGET ${target_name})
    message(STATUS "Kordex dependency '${dependency_name}' already available as ${target_name}")
    return()
  endif()

  if(NOT EXISTS "${dependency_dir}/CMakeLists.txt")
    message(FATAL_ERROR
        "Kordex dependency '${dependency_name}' is missing at: ${dependency_dir}\n"
        "Run:\n"
        "  git submodule update --init --recursive")
  endif()

  message(STATUS "Adding Kordex dependency: ${dependency_name}")

  add_subdirectory(
      "${dependency_dir}"
      "${CMAKE_BINARY_DIR}/deps/${dependency_name}")

  if(NOT TARGET ${target_name})
    message(FATAL_ERROR
        "Kordex dependency '${dependency_name}' did not define required target '${target_name}'")
  endif()
endfunction()

# --------------------------------------------------------------------
# Vix dependencies used by Kordex Runtime
# --------------------------------------------------------------------
kordex_add_local_dependency(
    vix_utils
    "${KORDEX_VIX_DEPS_DIR}/utils"
    vix::utils)

kordex_add_local_dependency(
    vix_async
    "${KORDEX_VIX_DEPS_DIR}/async"
    vix::async)

kordex_add_local_dependency(
    vix_error
    "${KORDEX_VIX_DEPS_DIR}/error"
    vix::error)

kordex_add_local_dependency(
    vix_fs
    "${KORDEX_VIX_DEPS_DIR}/fs"
    vix::fs)

kordex_add_local_dependency(
    vix_json
    "${KORDEX_VIX_DEPS_DIR}/json"
    vix::json)

kordex_add_local_dependency(
    vix_log
    "${KORDEX_VIX_DEPS_DIR}/log"
    vix::log)

kordex_add_local_dependency(
    vix_path
    "${KORDEX_VIX_DEPS_DIR}/path"
    vix::path)

kordex_add_local_dependency(
    vix_env
    "${KORDEX_VIX_DEPS_DIR}/env"
    vix::env)

kordex_add_local_dependency(
    vix_process
    "${KORDEX_VIX_DEPS_DIR}/process"
    vix::process)

kordex_add_local_dependency(
    vix_time
    "${KORDEX_VIX_DEPS_DIR}/time"
    vix::time)

# --------------------------------------------------------------------
# Extra Vix dependencies used by Kordex Std
# --------------------------------------------------------------------
if(KORDEX_ENABLE_STD_CRYPTO)
  kordex_add_local_dependency(
      vix_crypto
      "${KORDEX_VIX_DEPS_DIR}/crypto"
      vix::crypto)
endif()

if(KORDEX_ENABLE_STD_HTTP)
  kordex_add_local_dependency(
      vix_http
      "${KORDEX_VIX_DEPS_DIR}/http"
      vix::http)
endif()

# --------------------------------------------------------------------
# Test dependency
# --------------------------------------------------------------------
if(KORDEX_BUILD_TESTS)
  kordex_add_local_dependency(
      vix_tests
      "${KORDEX_VIX_DEPS_DIR}/tests"
      vix::tests)
endif()
