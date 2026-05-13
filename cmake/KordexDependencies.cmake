#  @file KordexDependencies.cmake
#  @author Softadastra
#
#  Copyright 2026, Softadastra. All rights reserved.
#  https://github.com/softadastra/kordex
#  Use of this source code is governed by a MIT license
#  that can be found in the LICENSE file.
#
# ====================================================================
# Kordex - Umbrella Dependencies
# ====================================================================

include_guard(GLOBAL)

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
      "${CMAKE_CURRENT_BINARY_DIR}/deps/${dependency_name}")

  if(NOT TARGET ${target_name})
    message(FATAL_ERROR
        "Kordex dependency '${dependency_name}' did not define required target '${target_name}'")
  endif()
endfunction()

# --------------------------------------------------------------------
# QuickJS dependency
# --------------------------------------------------------------------
function(kordex_add_quickjs)
  if(TARGET quickjs OR TARGET kordex_quickjs)
    message(STATUS "Kordex dependency 'quickjs' already available")
    return()
  endif()

  if(NOT KORDEX_ENABLE_QUICKJS)
    return()
  endif()

  include(FetchContent)

  message(STATUS "Adding Kordex dependency: quickjs")

  FetchContent_Declare(
      quickjs
      GIT_REPOSITORY https://github.com/bellard/quickjs.git
      GIT_TAG master
      GIT_SHALLOW TRUE)

  FetchContent_GetProperties(quickjs)

  if(NOT quickjs_POPULATED)
    FetchContent_Populate(quickjs)
  endif()

  set(KORDEX_QUICKJS_SOURCE_DIR "${quickjs_SOURCE_DIR}")

  if(NOT EXISTS "${KORDEX_QUICKJS_SOURCE_DIR}/quickjs.c")
    message(FATAL_ERROR
        "QuickJS source file was not found: ${KORDEX_QUICKJS_SOURCE_DIR}/quickjs.c")
  endif()

  set(KORDEX_QUICKJS_SOURCES
      "${KORDEX_QUICKJS_SOURCE_DIR}/quickjs.c"
      "${KORDEX_QUICKJS_SOURCE_DIR}/libregexp.c"
      "${KORDEX_QUICKJS_SOURCE_DIR}/libunicode.c"
      "${KORDEX_QUICKJS_SOURCE_DIR}/cutils.c")

  if(EXISTS "${KORDEX_QUICKJS_SOURCE_DIR}/libbf.c")
    list(APPEND KORDEX_QUICKJS_SOURCES
        "${KORDEX_QUICKJS_SOURCE_DIR}/libbf.c")
  endif()

  if(EXISTS "${KORDEX_QUICKJS_SOURCE_DIR}/dtoa.c")
    list(APPEND KORDEX_QUICKJS_SOURCES
        "${KORDEX_QUICKJS_SOURCE_DIR}/dtoa.c")
  endif()

  add_library(kordex_quickjs STATIC
      ${KORDEX_QUICKJS_SOURCES})

  add_library(quickjs ALIAS kordex_quickjs)

    set(KORDEX_QUICKJS_INCLUDE_DIR
      "${CMAKE_CURRENT_BINARY_DIR}/quickjs-include")

  file(MAKE_DIRECTORY "${KORDEX_QUICKJS_INCLUDE_DIR}")

  file(COPY
      "${KORDEX_QUICKJS_SOURCE_DIR}/quickjs.h"
      DESTINATION
        "${KORDEX_QUICKJS_INCLUDE_DIR}")

  if(EXISTS "${KORDEX_QUICKJS_SOURCE_DIR}/quickjs-libc.h")
    file(COPY
        "${KORDEX_QUICKJS_SOURCE_DIR}/quickjs-libc.h"
        DESTINATION
          "${KORDEX_QUICKJS_INCLUDE_DIR}")
  endif()

  target_include_directories(kordex_quickjs
      PUBLIC
        "${KORDEX_QUICKJS_INCLUDE_DIR}")

  # ------------------------------------------------------------------
  # QuickJS Windows compatibility headers for MSVC
  # ------------------------------------------------------------------
  if(WIN32 AND MSVC)
    set(KORDEX_QUICKJS_COMPAT_DIR
        "${CMAKE_CURRENT_BINARY_DIR}/quickjs-msvc-compat")

    file(MAKE_DIRECTORY
        "${KORDEX_QUICKJS_COMPAT_DIR}/sys")

    file(WRITE
        "${KORDEX_QUICKJS_COMPAT_DIR}/sys/time.h"
        [=[
  #ifndef KORDEX_QUICKJS_Msvc_SYS_TIME_H
  #define KORDEX_QUICKJS_Msvc_SYS_TIME_H

  #ifdef _WIN32

  #ifndef NOMINMAX
  #define NOMINMAX
  #endif

  #include <windows.h>
  #include <time.h>

  #ifndef _TIMEVAL_DEFINED
  #define _TIMEVAL_DEFINED
  struct timeval
  {
    long tv_sec;
    long tv_usec;
  };
  #endif

  static inline int gettimeofday(struct timeval *tv, void *tz)
  {
    (void)tz;

    if (tv == 0)
    {
      return -1;
    }

    FILETIME file_time;
    ULARGE_INTEGER value;

    GetSystemTimeAsFileTime(&file_time);

    value.LowPart = file_time.dwLowDateTime;
    value.HighPart = file_time.dwHighDateTime;

    /*
    * FILETIME is the number of 100-nanosecond intervals since
    * 1601-01-01. Unix time starts at 1970-01-01.
    */
    unsigned long long ticks = value.QuadPart;
    ticks -= 116444736000000000ULL;

    tv->tv_sec = (long)(ticks / 10000000ULL);
    tv->tv_usec = (long)((ticks % 10000000ULL) / 10ULL);

    return 0;
  }

  #endif

  #endif
  ]=])

    target_include_directories(kordex_quickjs
        PRIVATE
          "${KORDEX_QUICKJS_COMPAT_DIR}")
  endif()

  target_compile_definitions(kordex_quickjs
      PRIVATE
        CONFIG_VERSION="kordex"
        _GNU_SOURCE)

  target_compile_options(kordex_quickjs
      PRIVATE
        $<$<C_COMPILER_ID:GNU,Clang,AppleClang>:-Wno-unused-parameter>
        $<$<C_COMPILER_ID:GNU,Clang,AppleClang>:-Wno-missing-field-initializers>
        $<$<C_COMPILER_ID:GNU,Clang,AppleClang>:-Wno-sign-compare>
        $<$<C_COMPILER_ID:GNU,Clang,AppleClang>:-Wno-unused-function>
        $<$<C_COMPILER_ID:GNU,Clang,AppleClang>:-Wno-implicit-fallthrough>)

  if(UNIX AND NOT APPLE)
    target_link_libraries(kordex_quickjs
        PUBLIC
          m
          dl
          pthread)
  elseif(UNIX)
    target_link_libraries(kordex_quickjs
        PUBLIC
          m)
  endif()
endfunction()

kordex_add_quickjs()

# --------------------------------------------------------------------
# Core Vix dependencies
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
    vix_log
    "${KORDEX_VIX_DEPS_DIR}/log"
    vix::log)

kordex_add_local_dependency(
    vix_json
    "${KORDEX_VIX_DEPS_DIR}/json"
    vix::json)

kordex_add_local_dependency(
    vix_fs
    "${KORDEX_VIX_DEPS_DIR}/fs"
    vix::fs)

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
# Optional Vix dependencies used by Kordex Std
# --------------------------------------------------------------------
if(KORDEX_ENABLE_STD_CRYPTO)
  kordex_add_local_dependency(
      vix_crypto
      "${KORDEX_VIX_DEPS_DIR}/crypto"
      vix::crypto)
endif()

if(KORDEX_ENABLE_STD_HTTP)
  kordex_add_local_dependency(
      vix_core
      "${KORDEX_VIX_DEPS_DIR}/core"
      vix::core)
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
