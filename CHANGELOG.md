# Changelog

All notable changes to Kordex will be documented in this file.

The format follows a simple release-oriented structure.

## [0.1.0] - 2026-01-01

### Added

- Added initial Kordex umbrella project.
- Added root CMake build system.
- Added umbrella target:

```txt
kordex::kordex
```

- Added root CMake files:
  - `cmake/KordexOptions.cmake`
  - `cmake/KordexDependencies.cmake`
  - `cmake/KordexModules.cmake`
  - `cmake/KordexInstall.cmake`
- Added root `CMakeLists.txt`.
- Added umbrella build marker:

```cmake
set(KORDEX_UMBRELLA_BUILD ON)
```

- Added root module build options:
  - `KORDEX_BUILD_RUNTIME`
  - `KORDEX_BUILD_BINDINGS`
  - `KORDEX_BUILD_STD`
  - `KORDEX_BUILD_CLI`
- Added root app/test/example options:
  - `KORDEX_BUILD_APP`
  - `KORDEX_BUILD_TESTS`
  - `KORDEX_BUILD_EXAMPLES`
- Added root developer options:
  - `KORDEX_ENABLE_WARNINGS`
  - `KORDEX_ENABLE_SANITIZERS`
- Added root dependency fetch policy:
  - `KORDEX_FETCH_VIX_DEPS`
  - `KORDEX_FETCH_TESTS`
- Added dependency tag options:
  - `KORDEX_VIX_GIT_TAG`
  - `KORDEX_RUNTIME_GIT_TAG`
  - `KORDEX_BINDINGS_GIT_TAG`
  - `KORDEX_STD_GIT_TAG`
  - `KORDEX_CLI_GIT_TAG`
- Added umbrella dependency loading for Vix modules:
  - `vix::async`
  - `vix::error`
  - `vix::fs`
  - `vix::json`
  - `vix::log`
  - `vix::path`
  - `vix::process`
  - `vix::time`
  - `vix::env`
  - `vix::crypto`
  - `vix::http`
  - `vix::tests`
- Added module loading order:
  - `modules/runtime`
  - `modules/bindings`
  - `modules/std`
  - `modules/cli`
- Added validation that `kordex::bindings` requires `kordex::runtime`.
- Added validation that `kordex::std` requires `kordex::runtime` and `kordex::bindings`.
- Added validation that `kordex::cli` requires `kordex::runtime`, `kordex::bindings`, and `kordex::std`.
- Added root build propagation to `modules/runtime`:
  - tests
  - examples
  - warnings
  - sanitizers
  - dependency fetch options
- Added root build propagation to `modules/bindings`:
  - tests
  - examples
  - warnings
  - sanitizers
  - dependency fetch options
- Added root build propagation to `modules/std`:
  - tests
  - examples
  - warnings
  - sanitizers
  - dependency fetch options
- Added root build propagation to `modules/cli`:
  - app
  - tests
  - examples
  - warnings
  - sanitizers
  - dependency fetch options
- Added standard module feature options:
  - `KORDEX_ENABLE_STD_CONSOLE`
  - `KORDEX_ENABLE_STD_FS`
  - `KORDEX_ENABLE_STD_PATH`
  - `KORDEX_ENABLE_STD_ENV`
  - `KORDEX_ENABLE_STD_PROCESS`
  - `KORDEX_ENABLE_STD_TIMER`
  - `KORDEX_ENABLE_STD_CRYPTO`
  - `KORDEX_ENABLE_STD_HTTP`
- Added CLI command feature options:
  - `KORDEX_ENABLE_CLI_INIT_COMMAND`
  - `KORDEX_ENABLE_CLI_RUN_COMMAND`
  - `KORDEX_ENABLE_CLI_CHECK_COMMAND`
  - `KORDEX_ENABLE_CLI_BUILD_COMMAND`
  - `KORDEX_ENABLE_CLI_REPL_COMMAND`
  - `KORDEX_ENABLE_CLI_VERSION_COMMAND`
- Added install support for root metadata:
  - `README.md`
  - `CHANGELOG.md`
  - `LICENSE`
- Added umbrella CMake helper installation.
- Added optional umbrella package config support.
- Added generated convenience aliases file:
  - `KordexTargets.cmake`
- Added convenience target aliases when available:
  - `Kordex::Runtime`
  - `Kordex::Bindings`
  - `Kordex::Std`
  - `Kordex::Cli`
- Added build summary output.
- Added install summary output.
- Added root README documenting:
  - architecture
  - modules
  - dependency direction
  - build commands
  - options
  - CLI usage
  - C++ API examples
  - roadmap

## Modules

### Runtime

- Integrated `modules/runtime` into the umbrella build.
- Exposes target:

```
kordex::runtime
```

- Runtime is the lowest Kordex layer.
- Runtime must not depend on `bindings`, `std`, or `cli`.

### Bindings

- Integrated `modules/bindings` into the umbrella build.
- Exposes target:

```
kordex::bindings
```

- Bindings depends on runtime.
- Bindings owns script-facing native bridge concepts.

### Std

- Integrated `modules/std` into the umbrella build.
- Exposes target:

```
kordex::std
```

- C++ namespace remains:

```cpp
namespace kordex::standard
```

- Std depends on `bindings` and `runtime`.
- Std owns built-in native modules such as `console`, `fs`, `path`, `env`, `process`, `timer`, `crypto`, and `http`.

### CLI

- Integrated `modules/cli` into the umbrella build.
- Exposes target:

```
kordex::cli
```

- Builds executable:

```
kordex
```

- CLI depends on `std`, `bindings`, and `runtime`.
- CLI owns the terminal interface and built-in commands.

## Build

- Added root build command support:

```bash
cmake -S . -B build-ninja -G Ninja \
  -DCMAKE_BUILD_TYPE=Debug \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_BUILD_TESTS=ON \
  -DKORDEX_BUILD_EXAMPLES=ON

cmake --build build-ninja
```

- Added support for building through Vix:

```bash
vix build --build-target all -v
```

- Added support for building only selected layers:
  - runtime only
  - runtime + bindings
  - full stack without CLI app
  - full stack with tests
  - full stack with examples

### Notes

- Kordex is now organized as an umbrella project.
- The root build controls dependency order.
- Internal modules should not fetch each other when built from the root project.
- The dependency direction is:

```txt
cli
  -> std
  -> bindings
  -> runtime
  -> vix modules
```

- The project is ready for full root-level configuration and build testing.
- JavaScript engine integration remains a next step through the bindings layer.

## Roadmap

### Planned

- Add `cmake/KordexConfig.cmake.in`.
- Add root-level integration tests.
- Add final package export validation.
- Connect a real JavaScript engine through `modules/bindings`.
- Connect `kordex run` and `kordex repl` to the real engine.
- Add TypeScript loading and checking.
- Add script import support for `kordex:` standard modules.
- Add real bundling for `kordex build`.
- Add minification backend.
- Add source map generation.
- Add package/project discovery from `kordex.json`.
- Add plugin command registration.
- Add shell completion generation.
- Add `install`/`update` commands.
- Add release packaging for the final `kordex` executable.
