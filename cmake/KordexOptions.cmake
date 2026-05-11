#  @file KordexOptions.cmake
#  @author Softadastra
#
#  Copyright 2026, Softadastra. All rights reserved.
#  https://github.com/softadastra/kordex
#  Use of this source code is governed by a MIT license
#  that can be found in the LICENSE file.
#
# ====================================================================
# Kordex - Umbrella Build Options
# ====================================================================

set(KORDEX_OPTIONS_INCLUDED ON)

# --------------------------------------------------------------------
# Umbrella build marker
# --------------------------------------------------------------------
set(KORDEX_UMBRELLA_BUILD
    ON
    CACHE BOOL
    "Build Kordex as an umbrella project"
    FORCE)

# --------------------------------------------------------------------
# Build modules
# --------------------------------------------------------------------
option(KORDEX_BUILD_RUNTIME "Build kordex::runtime" ON)
option(KORDEX_BUILD_BINDINGS "Build kordex::bindings" ON)
option(KORDEX_BUILD_STD "Build kordex::standard" ON)
option(KORDEX_BUILD_CLI "Build kordex::cli" ON)

# --------------------------------------------------------------------
# Build app, tests, and examples
# --------------------------------------------------------------------
option(KORDEX_BUILD_APP "Build the final kordex executable" ON)
option(KORDEX_BUILD_TESTS "Build all Kordex tests" OFF)
option(KORDEX_BUILD_EXAMPLES "Build all Kordex examples" OFF)

# --------------------------------------------------------------------
# Install options
# --------------------------------------------------------------------
option(KORDEX_ENABLE_INSTALL "Generate install rules for Kordex umbrella" OFF)

# --------------------------------------------------------------------
# Developer options
# --------------------------------------------------------------------
option(KORDEX_ENABLE_WARNINGS "Enable compiler warnings for Kordex modules" ON)
option(KORDEX_ENABLE_SANITIZERS "Enable sanitizers for Kordex modules" OFF)

# --------------------------------------------------------------------
# Runtime module options
# --------------------------------------------------------------------
set(KORDEX_RUNTIME_BUILD_TESTS
    ${KORDEX_BUILD_TESTS}
    CACHE BOOL
    "Build Kordex Runtime tests"
    FORCE)

set(KORDEX_RUNTIME_BUILD_EXAMPLES
    ${KORDEX_BUILD_EXAMPLES}
    CACHE BOOL
    "Build Kordex Runtime examples"
    FORCE)

set(KORDEX_RUNTIME_ENABLE_WARNINGS
    ${KORDEX_ENABLE_WARNINGS}
    CACHE BOOL
    "Enable warnings for Kordex Runtime"
    FORCE)

set(KORDEX_RUNTIME_ENABLE_SANITIZERS
    ${KORDEX_ENABLE_SANITIZERS}
    CACHE BOOL
    "Enable sanitizers for Kordex Runtime"
    FORCE)

# --------------------------------------------------------------------
# Bindings module options
# --------------------------------------------------------------------
set(KORDEX_BINDINGS_BUILD_TESTS
    ${KORDEX_BUILD_TESTS}
    CACHE BOOL
    "Build Kordex Bindings tests"
    FORCE)

set(KORDEX_BINDINGS_BUILD_EXAMPLES
    ${KORDEX_BUILD_EXAMPLES}
    CACHE BOOL
    "Build Kordex Bindings examples"
    FORCE)

set(KORDEX_BINDINGS_ENABLE_WARNINGS
    ${KORDEX_ENABLE_WARNINGS}
    CACHE BOOL
    "Enable warnings for Kordex Bindings"
    FORCE)

set(KORDEX_BINDINGS_ENABLE_SANITIZERS
    ${KORDEX_ENABLE_SANITIZERS}
    CACHE BOOL
    "Enable sanitizers for Kordex Bindings"
    FORCE)

# --------------------------------------------------------------------
# Std module options
# --------------------------------------------------------------------
set(KORDEX_STD_BUILD_TESTS
    ${KORDEX_BUILD_TESTS}
    CACHE BOOL
    "Build Kordex Std tests"
    FORCE)

set(KORDEX_STD_BUILD_EXAMPLES
    ${KORDEX_BUILD_EXAMPLES}
    CACHE BOOL
    "Build Kordex Std examples"
    FORCE)

set(KORDEX_STD_ENABLE_WARNINGS
    ${KORDEX_ENABLE_WARNINGS}
    CACHE BOOL
    "Enable warnings for Kordex Std"
    FORCE)

set(KORDEX_STD_ENABLE_SANITIZERS
    ${KORDEX_ENABLE_SANITIZERS}
    CACHE BOOL
    "Enable sanitizers for Kordex Std"
    FORCE)

# --------------------------------------------------------------------
# CLI module options
# --------------------------------------------------------------------
set(KORDEX_CLI_BUILD_APP
    ${KORDEX_BUILD_APP}
    CACHE BOOL
    "Build Kordex CLI executable"
    FORCE)

set(KORDEX_CLI_BUILD_TESTS
    ${KORDEX_BUILD_TESTS}
    CACHE BOOL
    "Build Kordex CLI tests"
    FORCE)

set(KORDEX_CLI_BUILD_EXAMPLES
    ${KORDEX_BUILD_EXAMPLES}
    CACHE BOOL
    "Build Kordex CLI examples"
    FORCE)

set(KORDEX_CLI_ENABLE_WARNINGS
    ${KORDEX_ENABLE_WARNINGS}
    CACHE BOOL
    "Enable warnings for Kordex CLI"
    FORCE)

set(KORDEX_CLI_ENABLE_SANITIZERS
    ${KORDEX_ENABLE_SANITIZERS}
    CACHE BOOL
    "Enable sanitizers for Kordex CLI"
    FORCE)

# --------------------------------------------------------------------
# Std feature options
# --------------------------------------------------------------------
option(KORDEX_ENABLE_STD_CONSOLE "Enable kordex:console module" ON)
option(KORDEX_ENABLE_STD_FS "Enable kordex:fs module" ON)
option(KORDEX_ENABLE_STD_PATH "Enable kordex:path module" ON)
option(KORDEX_ENABLE_STD_ENV "Enable kordex:env module" ON)
option(KORDEX_ENABLE_STD_PROCESS "Enable kordex:process module" ON)
option(KORDEX_ENABLE_STD_TIMER "Enable kordex:timer module" ON)
option(KORDEX_ENABLE_STD_CRYPTO "Enable kordex:crypto module" ON)
option(KORDEX_ENABLE_STD_HTTP "Enable kordex:http module" ON)

set(KORDEX_STD_ENABLE_CONSOLE
    ${KORDEX_ENABLE_STD_CONSOLE}
    CACHE BOOL
    "Enable kordex:console module"
    FORCE)

set(KORDEX_STD_ENABLE_FS
    ${KORDEX_ENABLE_STD_FS}
    CACHE BOOL
    "Enable kordex:fs module"
    FORCE)

set(KORDEX_STD_ENABLE_PATH
    ${KORDEX_ENABLE_STD_PATH}
    CACHE BOOL
    "Enable kordex:path module"
    FORCE)

set(KORDEX_STD_ENABLE_ENV
    ${KORDEX_ENABLE_STD_ENV}
    CACHE BOOL
    "Enable kordex:env module"
    FORCE)

set(KORDEX_STD_ENABLE_PROCESS
    ${KORDEX_ENABLE_STD_PROCESS}
    CACHE BOOL
    "Enable kordex:process module"
    FORCE)

set(KORDEX_STD_ENABLE_TIMER
    ${KORDEX_ENABLE_STD_TIMER}
    CACHE BOOL
    "Enable kordex:timer module"
    FORCE)

set(KORDEX_STD_ENABLE_CRYPTO
    ${KORDEX_ENABLE_STD_CRYPTO}
    CACHE BOOL
    "Enable kordex:crypto module"
    FORCE)

set(KORDEX_STD_ENABLE_HTTP
    ${KORDEX_ENABLE_STD_HTTP}
    CACHE BOOL
    "Enable kordex:http module"
    FORCE)

# --------------------------------------------------------------------
# CLI command options
# --------------------------------------------------------------------
option(KORDEX_ENABLE_CLI_INIT_COMMAND "Enable kordex init command" ON)
option(KORDEX_ENABLE_CLI_RUN_COMMAND "Enable kordex run command" ON)
option(KORDEX_ENABLE_CLI_CHECK_COMMAND "Enable kordex check command" ON)
option(KORDEX_ENABLE_CLI_BUILD_COMMAND "Enable kordex build command" ON)
option(KORDEX_ENABLE_CLI_REPL_COMMAND "Enable kordex repl command" ON)
option(KORDEX_ENABLE_CLI_VERSION_COMMAND "Enable kordex version command" ON)

set(KORDEX_CLI_ENABLE_INIT_COMMAND
    ${KORDEX_ENABLE_CLI_INIT_COMMAND}
    CACHE BOOL
    "Enable kordex init command"
    FORCE)

set(KORDEX_CLI_ENABLE_RUN_COMMAND
    ${KORDEX_ENABLE_CLI_RUN_COMMAND}
    CACHE BOOL
    "Enable kordex run command"
    FORCE)

set(KORDEX_CLI_ENABLE_CHECK_COMMAND
    ${KORDEX_ENABLE_CLI_CHECK_COMMAND}
    CACHE BOOL
    "Enable kordex check command"
    FORCE)

set(KORDEX_CLI_ENABLE_BUILD_COMMAND
    ${KORDEX_ENABLE_CLI_BUILD_COMMAND}
    CACHE BOOL
    "Enable kordex build command"
    FORCE)

set(KORDEX_CLI_ENABLE_REPL_COMMAND
    ${KORDEX_ENABLE_CLI_REPL_COMMAND}
    CACHE BOOL
    "Enable kordex repl command"
    FORCE)

set(KORDEX_CLI_ENABLE_VERSION_COMMAND
    ${KORDEX_ENABLE_CLI_VERSION_COMMAND}
    CACHE BOOL
    "Enable kordex version command"
    FORCE)

# --------------------------------------------------------------------
# Dependency version policy
# --------------------------------------------------------------------
set(KORDEX_VIX_GIT_TAG
    "main"
    CACHE STRING
    "Git tag or branch used for Vix dependencies")

set(KORDEX_RUNTIME_GIT_TAG
    "main"
    CACHE STRING
    "Git tag or branch used for Kordex Runtime")

set(KORDEX_BINDINGS_GIT_TAG
    "main"
    CACHE STRING
    "Git tag or branch used for Kordex Bindings")

set(KORDEX_STD_GIT_TAG
    "main"
    CACHE STRING
    "Git tag or branch used for Kordex Std")

set(KORDEX_CLI_GIT_TAG
    "main"
    CACHE STRING
    "Git tag or branch used for Kordex CLI")

# --------------------------------------------------------------------
# Dependency fetch policy
# --------------------------------------------------------------------
option(KORDEX_FETCH_VIX_DEPS "Fetch missing Vix dependencies" OFF)
option(KORDEX_FETCH_TESTS "Fetch missing test dependency" OFF)

# Runtime dependencies
set(KORDEX_RUNTIME_FETCH_ASYNC
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::async if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_ERROR
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::error if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_FS
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::fs if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_JSON
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::json if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_LOG
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::log if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_PATH
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::path if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_PROCESS
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::process if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_TIME
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::time if missing"
    FORCE)

set(KORDEX_RUNTIME_FETCH_TESTS
    ${KORDEX_FETCH_TESTS}
    CACHE BOOL
    "Auto-fetch vix::tests if missing"
    FORCE)

# Bindings dependencies
set(KORDEX_BINDINGS_FETCH_RUNTIME
    OFF
    CACHE BOOL
    "Auto-fetch kordex::runtime if missing"
    FORCE)

set(KORDEX_BINDINGS_FETCH_ERROR
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::error if missing"
    FORCE)

set(KORDEX_BINDINGS_FETCH_JSON
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::json if missing"
    FORCE)

set(KORDEX_BINDINGS_FETCH_LOG
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::log if missing"
    FORCE)

set(KORDEX_BINDINGS_FETCH_TESTS
    ${KORDEX_FETCH_TESTS}
    CACHE BOOL
    "Auto-fetch vix::tests if missing"
    FORCE)

# Std dependencies
set(KORDEX_STD_FETCH_RUNTIME
    OFF
    CACHE BOOL
    "Auto-fetch kordex::runtime if missing"
    FORCE)

set(KORDEX_STD_FETCH_BINDINGS
    OFF
    CACHE BOOL
    "Auto-fetch kordex::bindings if missing"
    FORCE)

set(KORDEX_STD_FETCH_ERROR
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::error if missing"
    FORCE)

set(KORDEX_STD_FETCH_LOG
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::log if missing"
    FORCE)

set(KORDEX_STD_FETCH_JSON
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::json if missing"
    FORCE)

set(KORDEX_STD_FETCH_FS
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::fs if missing"
    FORCE)

set(KORDEX_STD_FETCH_PATH
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::path if missing"
    FORCE)

set(KORDEX_STD_FETCH_ENV
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::env if missing"
    FORCE)

set(KORDEX_STD_FETCH_PROCESS
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::process if missing"
    FORCE)

set(KORDEX_STD_FETCH_TIME
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::time if missing"
    FORCE)

set(KORDEX_STD_FETCH_CRYPTO
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::crypto if missing"
    FORCE)

set(KORDEX_STD_FETCH_CORE
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::core if missing"
    FORCE)

set(KORDEX_STD_FETCH_TESTS
    ${KORDEX_FETCH_TESTS}
    CACHE BOOL
    "Auto-fetch vix::tests if missing"
    FORCE)

# CLI dependencies
set(KORDEX_CLI_FETCH_RUNTIME
    OFF
    CACHE BOOL
    "Auto-fetch kordex::runtime if missing"
    FORCE)

set(KORDEX_CLI_FETCH_BINDINGS
    OFF
    CACHE BOOL
    "Auto-fetch kordex::bindings if missing"
    FORCE)

set(KORDEX_CLI_FETCH_STD
    OFF
    CACHE BOOL
    "Auto-fetch kordex::std if missing"
    FORCE)

set(KORDEX_CLI_FETCH_ERROR
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::error if missing"
    FORCE)

set(KORDEX_CLI_FETCH_LOG
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::log if missing"
    FORCE)

set(KORDEX_CLI_FETCH_JSON
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::json if missing"
    FORCE)

set(KORDEX_CLI_FETCH_FS
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::fs if missing"
    FORCE)

set(KORDEX_CLI_FETCH_PATH
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::path if missing"
    FORCE)

set(KORDEX_CLI_FETCH_ENV
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::env if missing"
    FORCE)

set(KORDEX_CLI_FETCH_PROCESS
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::process if missing"
    FORCE)

set(KORDEX_CLI_FETCH_TIME
    ${KORDEX_FETCH_VIX_DEPS}
    CACHE BOOL
    "Auto-fetch vix::time if missing"
    FORCE)

set(KORDEX_CLI_FETCH_TESTS
    ${KORDEX_FETCH_TESTS}
    CACHE BOOL
    "Auto-fetch vix::tests if missing"
    FORCE)
