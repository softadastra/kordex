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

include(FetchContent)

# --------------------------------------------------------------------
# Dependency helper
# --------------------------------------------------------------------
function(kordex_fetch_dependency dependency_name repository tag)
  if(${dependency_name}_POPULATED)
    return()
  endif()

  FetchContent_Declare(
      ${dependency_name}
      GIT_REPOSITORY ${repository}
      GIT_TAG ${tag}
      GIT_SHALLOW TRUE)

  FetchContent_MakeAvailable(${dependency_name})
endfunction()

function(kordex_require_target target_name package_name dependency_name fetch_option repository tag)
  if(TARGET ${target_name})
    return()
  endif()

  find_package(${package_name} CONFIG QUIET)

  if(TARGET ${target_name})
    return()
  endif()

  if(${fetch_option})
    kordex_fetch_dependency(
        ${dependency_name}
        ${repository}
        ${tag})

    if(TARGET ${target_name})
      return()
    endif()
  endif()

  message(FATAL_ERROR
      "Required dependency target '${target_name}' was not found. "
      "Install package '${package_name}' or enable ${fetch_option}.")
endfunction()

# --------------------------------------------------------------------
# Vix dependencies used by Kordex Runtime
# --------------------------------------------------------------------
kordex_require_target(
    vix::async
    vix_async
    vix_async
    KORDEX_RUNTIME_FETCH_ASYNC
    https://github.com/vixcpp/async.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::error
    vix_error
    vix_error
    KORDEX_RUNTIME_FETCH_ERROR
    https://github.com/vixcpp/error.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::fs
    vix_fs
    vix_fs
    KORDEX_RUNTIME_FETCH_FS
    https://github.com/vixcpp/fs.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::json
    vix_json
    vix_json
    KORDEX_RUNTIME_FETCH_JSON
    https://github.com/vixcpp/json.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::log
    vix_log
    vix_log
    KORDEX_RUNTIME_FETCH_LOG
    https://github.com/vixcpp/log.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::path
    vix_path
    vix_path
    KORDEX_RUNTIME_FETCH_PATH
    https://github.com/vixcpp/path.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::process
    vix_process
    vix_process
    KORDEX_RUNTIME_FETCH_PROCESS
    https://github.com/vixcpp/process.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::time
    vix_time
    vix_time
    KORDEX_RUNTIME_FETCH_TIME
    https://github.com/vixcpp/time.git
    ${KORDEX_VIX_GIT_TAG})

# --------------------------------------------------------------------
# Extra Vix dependencies used by Kordex Std
# --------------------------------------------------------------------
kordex_require_target(
    vix::env
    vix_env
    vix_env
    KORDEX_STD_FETCH_ENV
    https://github.com/vixcpp/env.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::crypto
    vix_crypto
    vix_crypto
    KORDEX_STD_FETCH_CRYPTO
    https://github.com/vixcpp/crypto.git
    ${KORDEX_VIX_GIT_TAG})

kordex_require_target(
    vix::http
    vix_http
    vix_http
    KORDEX_STD_FETCH_HTTP
    https://github.com/vixcpp/http.git
    ${KORDEX_VIX_GIT_TAG})

# --------------------------------------------------------------------
# Test dependency
# --------------------------------------------------------------------
if(KORDEX_BUILD_TESTS)
  kordex_require_target(
      vix::tests
      vix_tests
      vix_tests
      KORDEX_FETCH_TESTS
      https://github.com/vixcpp/tests.git
      ${KORDEX_VIX_GIT_TAG})
endif()
