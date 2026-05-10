# Kordex

A JavaScript runtime for reliable local-first applications.

Kordex is built on top of Vix and Softadastra principles. It provides a runtime-oriented foundation for JavaScript and TypeScript applications that need clear execution, native modules, durable architecture, and a path toward local-first reliability.

## Purpose

Kordex is the umbrella project that assembles the core Kordex modules:

```txt
kordex
  -> runtime
  -> bindings
  -> std
  -> cli
```

Each module is independent, but the umbrella build makes it possible to compile the full stack from the root repository.

## Architecture

```
kordex/
├── CMakeLists.txt
├── cmake/
│   ├── KordexOptions.cmake
│   ├── KordexDependencies.cmake
│   ├── KordexModules.cmake
│   └── KordexInstall.cmake
├── modules/
│   ├── runtime/
│   ├── bindings/
│   ├── std/
│   └── cli/
├── examples/
├── docs/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── package.json
└── tsconfig.json
```

## Modules

### modules/runtime

Core runtime layer.

It owns execution-oriented concepts:

- `Runtime`
- `RuntimeOptions`
- `RuntimeConfig`
- `RuntimeResult`
- `SourceFile`
- `Manifest`
- `Task`
- `Timer`
- Process helpers

Target:

```
kordex::runtime
```

### modules/bindings

Native binding layer between C++ and script-facing APIs.

It owns:

- `Value`
- `Function`
- `Object`
- `Module`
- `ModuleRegistry`
- `NativeFunction`
- `NativeModule`
- `Engine`
- `EngineContext`
- `RuntimeBridge`
- `Script`

Target:

```
kordex::bindings
```

### modules/std

Standard native modules exposed to Kordex applications.

It owns:

- `console`
- `fs`
- `path`
- `env`
- `process`
- `timer`
- `crypto`
- `http`

Target:

```
kordex::std
```

C++ namespace:

```cpp
namespace kordex::standard
```

The namespace is intentionally not `kordex::std` because it would conflict with the C++ standard namespace.

### modules/cli

Official command line interface.

It owns:

- `kordex` executable
- argument parser
- command registry
- help formatter
- output renderer
- `init` command
- `run` command
- `check` command
- `build` command
- `repl` command
- `version` command

Targets:

```
kordex::cli
kordex
```

## Dependency direction

The dependency direction must stay one-way:

```txt
cli
  -> std
  -> bindings
  -> runtime
  -> vix modules
```

Rules:

- `runtime` must not depend on `bindings`
- `runtime` must not depend on `std`
- `runtime` must not depend on `cli`
- `bindings` may depend on `runtime`
- `std` may depend on `bindings` and `runtime`
- `cli` may depend on `std`, `bindings`, and `runtime`

This avoids circular dependencies and keeps every layer clean.

## Build from root

From the root repository:

```bash
cmake -S . -B build-ninja -G Ninja \
  -DCMAKE_BUILD_TYPE=Debug \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_BUILD_TESTS=ON \
  -DKORDEX_BUILD_EXAMPLES=ON

cmake --build build-ninja
```

Or with Vix:

```bash
vix build --build-target all -v
```

## Run the CLI

After building:

```bash
./build-ninja/modules/cli/kordex --help
./build-ninja/modules/cli/kordex version
```

Depending on the generator output layout, the binary can also be found with:

```bash
find build-ninja -type f -name kordex
```

## Build options

Root-level options:

```
KORDEX_BUILD_RUNTIME=ON
KORDEX_BUILD_BINDINGS=ON
KORDEX_BUILD_STD=ON
KORDEX_BUILD_CLI=ON

KORDEX_BUILD_APP=ON
KORDEX_BUILD_TESTS=OFF
KORDEX_BUILD_EXAMPLES=OFF

KORDEX_ENABLE_WARNINGS=ON
KORDEX_ENABLE_SANITIZERS=OFF

KORDEX_FETCH_VIX_DEPS=ON
KORDEX_FETCH_TESTS=ON
```

### Standard module options

```
KORDEX_ENABLE_STD_CONSOLE=ON
KORDEX_ENABLE_STD_FS=ON
KORDEX_ENABLE_STD_PATH=ON
KORDEX_ENABLE_STD_ENV=ON
KORDEX_ENABLE_STD_PROCESS=ON
KORDEX_ENABLE_STD_TIMER=ON
KORDEX_ENABLE_STD_CRYPTO=ON
KORDEX_ENABLE_STD_HTTP=ON
```

### CLI command options

```
KORDEX_ENABLE_CLI_INIT_COMMAND=ON
KORDEX_ENABLE_CLI_RUN_COMMAND=ON
KORDEX_ENABLE_CLI_CHECK_COMMAND=ON
KORDEX_ENABLE_CLI_BUILD_COMMAND=ON
KORDEX_ENABLE_CLI_REPL_COMMAND=ON
KORDEX_ENABLE_CLI_VERSION_COMMAND=ON
```

### Dependency tags

```
KORDEX_VIX_GIT_TAG=main
KORDEX_RUNTIME_GIT_TAG=main
KORDEX_BINDINGS_GIT_TAG=main
KORDEX_STD_GIT_TAG=main
KORDEX_CLI_GIT_TAG=main
```

## Umbrella build behavior

The root build defines:

```cmake
set(KORDEX_UMBRELLA_BUILD ON)
```

This tells internal modules that they are being built from the root project.

In umbrella mode:

- `runtime` is added first
- `bindings` is added after `runtime`
- `std` is added after `bindings`
- `cli` is added last

Module order:

```cmake
add_subdirectory(modules/runtime)
add_subdirectory(modules/bindings)
add_subdirectory(modules/std)
add_subdirectory(modules/cli)
```

The modules must not fetch each other when built inside the umbrella. The root project controls the dependency order.

## Build only the runtime

```bash
cmake -S . -B build-runtime -G Ninja \
  -DKORDEX_BUILD_RUNTIME=ON \
  -DKORDEX_BUILD_BINDINGS=OFF \
  -DKORDEX_BUILD_STD=OFF \
  -DKORDEX_BUILD_CLI=OFF

cmake --build build-runtime
```

## Build runtime and bindings

```bash
cmake -S . -B build-bindings -G Ninja \
  -DKORDEX_BUILD_RUNTIME=ON \
  -DKORDEX_BUILD_BINDINGS=ON \
  -DKORDEX_BUILD_STD=OFF \
  -DKORDEX_BUILD_CLI=OFF

cmake --build build-bindings
```

## Build without CLI app

```bash
cmake -S . -B build-lib -G Ninja \
  -DKORDEX_BUILD_APP=OFF

cmake --build build-lib
```

## Build tests

```bash
cmake -S . -B build-ninja -G Ninja \
  -DKORDEX_BUILD_TESTS=ON

cmake --build build-ninja

ctest --test-dir build-ninja --output-on-failure
```

## Build examples

```bash
cmake -S . -B build-ninja -G Ninja \
  -DKORDEX_BUILD_EXAMPLES=ON

cmake --build build-ninja
```

## Public C++ usage

Use the CLI facade:

```cpp
#include <kordex/cli/Cli.hpp>

int main(int argc, char **argv)
{
  return kordex::cli::run_cli(argc, argv);
}
```

Use the runtime directly:

```cpp
#include <kordex/runtime/Runtime.hpp>

int main()
{
  auto runtime_result = kordex::runtime::Runtime::from_options(
      kordex::runtime::RuntimeOptions::defaults());

  if (!runtime_result)
  {
    return 1;
  }

  auto runtime = std::move(runtime_result.value());

  auto start_error = runtime.start();
  if (start_error)
  {
    return 1;
  }

  auto result = runtime.run_file("src/main.js");

  (void)runtime.shutdown();

  return result.succeeded() ? 0 : 1;
}
```

Use standard modules:

```cpp
#include <kordex/std/Std.hpp>

int main()
{
  auto module_result = kordex::standard::create_module("console");

  if (!module_result)
  {
    return 1;
  }

  auto module = std::move(module_result.value());

  auto result = module.call(
      "log",
      {kordex::bindings::Value::string("Hello from Kordex")});

  return result ? 0 : 1;
}
```

## CLI usage

```bash
kordex --help
kordex version
kordex init app
kordex run src/main.js
kordex check src/main.js
kordex build src/main.js
kordex repl
```

## Current status

Kordex currently provides the full C++ structure for:

- runtime layer
- bindings layer
- standard modules
- CLI layer
- umbrella CMake build

The first implementation focuses on structure, modularity, command flow, and integration.

The JavaScript engine connection comes next through the bindings layer.

## Roadmap

Planned next steps:

- connect a real JavaScript engine
- connect `run`/`repl` to the engine
- add TypeScript loading/checking
- add module import support
- connect `std` modules to script imports
- add real bundling for `build`
- add source map generation
- add permission system
- add package/project discovery
- add plugin commands
- add `install`/`update` commands
- add integration tests for the final CLI

## Design principles

Kordex should stay:

- simple
- modular
- explicit
- runtime-oriented
- local-first ready
- easy to build from source
- cleanly separated by module

## License

MIT License.
