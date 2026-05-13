# Kordex

A JavaScript runtime for reliable local-first applications.

Kordex is built on top of Vix and Softadastra.
It provides a JavaScript/TypeScript runtime layer designed for applications that must keep working under real-world network conditions, offline usage, local-first workflows, and controlled permissions.

## Vision

Kordex is not just another JavaScript runtime.

It is designed for reliable local-first applications where:

- local execution matters
- offline behavior matters
- durable state matters
- sync and convergence matter
- permissions must be explicit
- native capabilities must be controlled
- the runtime should remain modular and embeddable

Kordex uses:

- **Vix** as the C++ runtime/system foundation
- **Softadastra** as the durability, sync, WAL, and local-first reliability layer
- **Kordex modules** as the JavaScript runtime, bindings, standard modules, and CLI

## Repository structure

```txt
kordex/
├── CMakeLists.txt
├── cmake/
├── docs/
├── examples/
├── modules/
│   ├── runtime/
│   ├── bindings/
│   ├── std/
│   └── cli/
├── README.md
├── CHANGELOG.md
└── LICENSE
```

## Modules

### modules/runtime

Core runtime foundation.

Provides:

- runtime configuration
- runtime lifecycle
- source file loading
- module resolver
- runtime loop
- cancellation
- timers
- tasks
- process facade
- diagnostics
- manifest loading
- permission model foundation

### modules/bindings

Native bindings and JavaScript engine bridge.

Provides:

- engine abstraction
- QuickJS backend
- script execution
- `eval()`
- TypeScript loading
- module loading
- JSON modules
- native module bridge
- native function bridge
- value conversion
- module cache

### modules/std

Standard native modules exposed to scripts.

Provides modules such as:

- `kordex:console`
- `kordex:fs`
- `kordex:path`
- `kordex:env`
- `kordex:process`
- `kordex:timer`
- `kordex:crypto`
- `kordex:http`

Sensitive modules are controlled by runtime permissions.

### modules/cli

User-facing command-line interface.

Provides:

- `kordex init`
- `kordex run`
- `kordex repl`
- `kordex check`
- `kordex build`
- `kordex install`
- `kordex update`
- `kordex version`
- `kordex help`

The CLI connects runtime, bindings, std modules, project discovery, permissions, plugin commands, and package lock generation.

## Features

- JavaScript execution with QuickJS
- TypeScript loading and basic transpilation
- `kordex run` for files or project entries
- `kordex repl --eval`
- Relative imports
- Extension resolution
- Directory `index.js` resolution
- JSON imports
- Standard modules through `kordex:` imports
- Permission-gated modules
- Project discovery via `kordex.json` or `package.json`
- Build command with module bundling
- Basic source map generation
- Plugin commands from project configuration
- `install` and `update` commands
- `kordex.lock` generation
- Integration tests for the final CLI workflow

## Quick start

Build the full project with QuickJS enabled:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON

With tests enabled:

```bash
vix build \
  --preset dev-ninja \
  -- \
  -DKORDEX_BUILD_TESTS=ON

vix tests -- --output-on-failure
```

````md
Install the CLI locally:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_ENABLE_INSTALL=ON

sudo cmake --install build-ninja --prefix /usr/local
```

If using the CLI binary:

```bash
kordex version
```

### Create a project

```bash
kordex init app
cd app
```

Run the project:

```bash
kordex run
```

Run a file directly:

```bash
kordex run src/main.js
```

Run TypeScript:

```bash
kordex run src/main.ts
```

Evaluate code:

```bash
kordex repl --eval "1 + 2"
```

## Project configuration

Kordex looks for:

- `kordex.json`
- `package.json`

Example `kordex.json`:

```json
{
  "name": "my-app",
  "version": "0.1.0",
  "entry": "src/main.ts",
  "registry": "https://registry.vixcpp.com",
  "dependencies": {
    "kordex/std": "0.1.0"
  },
  "scripts": {
    "dev": "kordex run src/main.ts",
    "build": "kordex build . --project"
  }
}
```

When running:

```bash
kordex run
```

Kordex resolves the entry from the project manifest.

## JavaScript

```javascript
const name = "Kordex";

"Hello " + name;
```

Run:

```bash
kordex run main.js
```

## TypeScript

```typescript
const name: string = "Kordex";

function hello(value: string): string {
  return "Hello " + value;
}

hello(name);
```

Run:

```bash
kordex run main.ts
```

TypeScript support is currently MVP-level. It performs basic checking and type stripping before sending JavaScript to the engine.

## Imports

Relative imports are supported:

```javascript
import { message } from "./lib/message.js";

message;
```

Extension resolution is supported:

```javascript
import { message } from "./lib/message";
```

Directory index resolution is supported:

```javascript
import { name } from "./pkg";
```

This resolves:
```
./pkg/index.js
```

JSON imports are supported:

```javascript
import user from "./data/user.json";

user.name;
```

## Standard modules

Standard modules use the `kordex:` prefix.

```javascript
import { join } from "kordex:path";

join("/tmp", "kordex", "app");
```

Some modules require explicit permissions.

## Permissions

Sensitive capabilities are disabled by default.

Available flags:

- `--allow-fs`
- `--allow-env`
- `--allow-net`
- `--allow-process`

Example:

```javascript
import { exists } from "kordex:fs";

exists("/tmp");
```

Run with permission:

```bash
kordex run main.js --allow-fs
```

Without `--allow-fs`, `kordex:fs` is not available to the script.

## Build

Bundle a file:

```bash
kordex build main.js --out-dir dist --force
```

Bundle a project:

```bash
kordex build . --project --out-dir dist --force
```

Choose output file:

```bash
kordex build . --project --out-dir dist --out-file app.js --force
```

Generate source map:

```bash
kordex build . --project --source-map --force
```

Output:
```
dist/main.js
dist/main.js.map
```

## Package management

Install dependencies from `kordex.json`:

```bash
kordex install
```

Install one package:

```bash
kordex install softadastra/plugin-example@0.1.0
```

Update dependencies:

```bash
kordex update
```

The package commands currently generate and update:
```
kordex.lock
```

The current implementation is a safe MVP. It resolves declared packages and lock metadata without automatically executing downloaded code.

## Plugin commands

Project plugin commands can be declared in `kordex.json`.

```json
{
  "plugins": {
    "commands": [
      {
        "name": "hello",
        "summary": "Run hello plugin",
        "run": "scripts/hello.ts",
        "aliases": ["hi"],
        "permissions": {
          "fs": false,
          "env": false,
          "net": false,
          "process": false
        }
      }
    ]
  }
}
```

Then:

```bash
kordex hello
```

or:

```bash
kordex hi
```

Plugin commands have isolated permissions and cannot override built-in commands.

## CLI commands

```txt
kordex init <name>
kordex run [file]
kordex repl --eval <source>
kordex check <file>
kordex build <file|project>
kordex install [package[@version]]
kordex update [package]
kordex version
kordex help
```

Global options:

```txt
-h, --help       Show help
-V, --version    Show version
-v, --verbose    Enable verbose output
--debug      Enable debug output
-q, --quiet      Disable normal output
--json       Render machine-readable JSON output
--no-color   Disable colored output
--dry-run    Show what would happen without executing
```

## Architecture

Kordex follows a layered architecture:
CLI
-> Runtime options
-> Permission bridge
-> Bindings engine
-> Module loader
-> TypeScript loader
-> QuickJS backend
-> Standard native modules
-> ScriptResult

The runtime layer handles project-level and execution-level configuration.
The bindings layer handles JavaScript engine execution.
The std layer exposes native modules.
The CLI layer connects everything into a user-facing tool.

## Runtime pipeline

For:

```bash
kordex run src/main.ts
```

The pipeline is:
CLI parses command
-> project/file resolved
-> RuntimeOptions created
-> permissions converted to StdOptions
-> Engine initialized
-> std modules installed according to permissions
-> Script loaded
-> TypeScript transformed if needed
-> imports resolved
-> modules bundled internally
-> QuickJS eval
-> ScriptResult rendered

## Build pipeline

For:

```bash
kordex build . --project
```

The pipeline is:
ProjectDiscovery
-> resolve entry
-> load script
-> analyze import graph
-> transform TypeScript
-> resolve JSON modules
-> bundle modules
-> write dist/main.js
-> optionally write dist/main.js.map

## Development status

Kordex is early-stage.

Implemented foundations:

- runtime module
- bindings module
- std module
- CLI module
- QuickJS execution
- TypeScript MVP loader
- module loader
- std imports
- build bundling
- source map MVP
- permission bridge
- project discovery
- plugin command discovery
- install/update lock generation
- integration tests

Still planned:

- full TypeScript compiler integration
- package downloads from registry
- real plugin execution
- richer source maps
- package import resolution
- native ES module execution
- object/function value bridge
- deeper Softadastra sync integration

## Build options

Common options:

- `KORDEX_BUILD_TESTS`
- `KORDEX_BUILD_EXAMPLES`
- `KORDEX_UMBRELLA_BUILD`

Bindings options:

- `KORDEX_BINDINGS_ENABLE_NATIVE_ENGINE`
- `KORDEX_BINDINGS_ENABLE_QUICKJS`
- `KORDEX_BINDINGS_ENABLE_V8`

Example QuickJS build from the umbrella repository:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON
```

## Tests

Run all tests:

```bash
vix tests -R kordex_cli_integration_tests
```

Run CLI integration tests:

```bash
vix tests -- --output-on-failure
```

The final CLI integration tests cover:

- `kordex run`
- `kordex repl --eval`
- relative imports
- JSON imports
- standard modules
- build output
- permissions

## Repositories

Kordex is organized as a modular runtime project.

Main modules:

- `kordex-runtime`
- `kordex-bindings`
- `kordex-std`
- `kordex-cli`

The umbrella repository brings them together under:
modules/

## License

MIT License.
