<table>
  <tr>
    <td valign="top" width="65%">

<h1>Kordex</h1>

<p>
  <a href="https://github.com/softadastra/kordex">
    <img src="https://img.shields.io/badge/GitHub-Repository-black?logo=github" />
  </a>
  <a href="https://github.com/softadastra/kordex/releases">
    <img src="https://img.shields.io/badge/Releases-Download-blue?logo=github" />
  </a>
</p>

<h3>A JavaScript and TypeScript runtime for reliable local-first applications.</h3>

<p>
  Kordex is a small JavaScript runtime built on top of <b>Vix.cpp</b> and <b>Softadastra</b>.
  It is designed for local-first, offline-ready, permission-controlled applications.
</p>

<p>
  <a href="https://github.com/softadastra/kordex"><b>Repository</b></a> ·
  <a href="https://github.com/vixcpp/vix"><b>Vix.cpp</b></a> ·
  <a href="https://softadastra.com"><b>Softadastra</b></a>
</p>

</td>

<td valign="middle" width="25%" align="right">

<img
src="https://res.cloudinary.com/dwjbed2xb/image/upload/v1778700533/kordex_kzrxcx.png"
width="260"
style="border-radius:50%; object-fit:cover;"
/>

</td>
  </tr>
</table>

## What is Kordex?

Kordex is a JavaScript runtime focused on reliability, local execution, and explicit permissions.

It lets you run JavaScript and TypeScript files, import local modules, use native standard modules, and build scripts into bundled output.

The long-term goal is to make JavaScript useful for applications that must continue working even when the network is unstable or unavailable.

Kordex is built for:

- local-first applications
- offline-ready tools
- permission-controlled scripts
- durable local workflows
- embeddable JavaScript execution
- native modules written in C++
- reliable applications built close to the system

## Why Kordex?

Most JavaScript runtimes are designed around online services, package ecosystems, and cloud-first workflows.

Kordex starts from a different question:

```txt
What if the application must keep working locally first?
```

That means:

- the runtime should be small
- native capabilities should be explicit
- filesystem, environment, process, and network access should be controlled
- local state should matter
- offline behavior should be part of the design
- the runtime should be easy to embed into C++ systems

Kordex uses:

- **Vix.cpp** as the C++ runtime and system foundation
- **Softadastra** as the reliability, durability, WAL, sync, and local-first layer
- **QuickJS** as the JavaScript engine backend
- **Kordex Std** as the native standard module layer
- **Kordex CLI** as the developer interface

## Quick example

Create a file:

```bash
touch main.js
```

Add:

```js
const name = "Kordex";

console.log("Hello from " + name);
```

Run it:

```bash
kordex run main.js
```

Output:

```txt
Hello from Kordex
```

## Install

Kordex is built with the Vix.cpp CLI.

Install Vix.cpp first:

### Linux and macOS

```bash
curl -fsSL https://vixcpp.com/install.sh | bash
```

### Windows PowerShell

```powershell
irm https://vixcpp.com/install.ps1 | iex
```

Verify Vix:

```bash
vix --version
```

Then build Kordex:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_ENABLE_INSTALL=ON
```

Install the CLI locally:

```bash
sudo cmake --install build-ninja --prefix /usr/local
hash -r
```

Verify Kordex:

```bash
kordex version
kordex help
```

## CLI

```txt
kordex <command> [options] [args]
```

Available commands:

```txt
help     Show help
init     Create a new Kordex project
run      Run a JavaScript or TypeScript file
check    Check a source file
build    Build a source file or project
repl     Start an interactive Kordex session
version  Show Kordex version
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

## Run JavaScript

```js
const runtime = "Kordex";

console.log(runtime);
```

Run:

```bash
kordex run main.js
```

Output:

```txt
Kordex
```

## Run TypeScript

```ts
const name: string = "Kordex";

function hello(value: string): string {
  return "Hello from " + value;
}

console.log(hello(name));
```

Run:

```bash
kordex run main.ts
```

Output:

```txt
Hello from Kordex
```

TypeScript support is currently MVP-level. It performs basic checking and type stripping before sending JavaScript to the engine.

## Use imports

Create `message.js`:

```js
export function message() {
  return "Import works";
}
```

Create `main.js`:

```js
import { message } from "./message.js";

console.log(message());
```

Run:

```bash
kordex run main.js
```

Output:

```txt
Import works
```

Extension resolution is supported:

```js
import { message } from "./message";

console.log(message());
```

## JSON imports

Create `user.json`:

```json
{
  "name": "Kordex",
  "type": "runtime"
}
```

Create `main.js`:

```js
import user from "./user.json";

console.log(user.name);
console.log(user.type);
```

Run:

```bash
kordex run main.js
```

Output:

```txt
Kordex
runtime
```

## Standard modules

Kordex exposes native modules through the `kordex:` prefix.

Available modules:

```txt
kordex:console
kordex:path
kordex:fs
kordex:env
kordex:process
kordex:timer
kordex:crypto
kordex:http
```

Safe utility modules can be enabled by default:

```txt
kordex:console
kordex:path
kordex:timer
kordex:crypto
```

Sensitive modules are controlled by permissions:

```txt
kordex:fs
kordex:env
kordex:process
kordex:http
```

## `kordex:console`

```js
import { log, info, warn, error, debug } from "kordex:console";

log("log works");
info("info works");
warn("warn works");
error("error works");
debug("debug works");
```

Run:

```bash
kordex run main.js
```

Output:

```txt
[log] log works
[info] info works
[warn] warn works
[error] error works
[debug] debug works
```

The global `console` object is also available:

```js
console.log("global console works");
console.error("global console error works");
```

## `kordex:path`

```js
import {
  normalize,
  join,
  dirname,
  basename,
  extension,
  isAbsolute,
  isRelative,
  separator,
} from "kordex:path";

console.log(normalize("/tmp/kordex/../kordex/app"));
console.log(join("/tmp", "kordex", "app"));
console.log(dirname("/tmp/kordex/app/main.js"));
console.log(basename("/tmp/kordex/app/main.js"));
console.log(extension("/tmp/kordex/app/main.js"));
console.log(isAbsolute("/tmp/kordex"));
console.log(isRelative("./main.js"));
console.log(separator);
```

Run:

```bash
kordex run main.js
```

Output on Linux/macOS:

```txt
/tmp/kordex/app
/tmp/kordex/app
/tmp/kordex/app
main.js
.js
true
true
/
```

## `kordex:timer`

```js
import { now, sleep, unixMs } from "kordex:timer";

const before = now();

sleep(10);

const after = now();

console.log(after >= before);
console.log(unixMs() > 0);
```

Run:

```bash
kordex run main.js
```

Output:

```txt
true
true
```

## `kordex:crypto`

```js
import { hash, random, randomInt, equals } from "kordex:crypto";

console.log(hash("kordex"));
console.log(random() >= 0);
console.log(random() < 1);
console.log(randomInt(1, 10) >= 1);
console.log(equals("hello", "hello"));
console.log(equals("hello", "world"));
```

Run:

```bash
kordex run main.js
```

Output shape:

```txt
<hex hash>
true
true
true
true
false
```

## Permissions

Kordex uses explicit permissions for sensitive native capabilities.

Available permission flags:

```txt
--allow-fs
--allow-env
--allow-net
--allow-process
```

### Filesystem access

```js
import {
  exists,
  isFile,
  isDirectory,
  writeText,
  readText,
  remove,
} from "kordex:fs";

const file = "/tmp/kordex-fs-test.txt";

console.log(exists("/tmp"));
console.log(isDirectory("/tmp"));

writeText(file, "Hello from kordex:fs");

console.log(exists(file));
console.log(isFile(file));
console.log(readText(file));

console.log(remove(file));
console.log(exists(file));
```

Run:

```bash
kordex run main.js --allow-fs
```

Output:

```txt
true
true
true
true
Hello from kordex:fs
true
false
```

Without `--allow-fs`, `kordex:fs` should not be available to the script.

### Environment access

```js
import { get, has, set, unset } from "kordex:env";

console.log(has("HOME"));
console.log(get("HOME") !== null);

set("KORDEX_TEST_ENV", "works");

console.log(has("KORDEX_TEST_ENV"));
console.log(get("KORDEX_TEST_ENV"));

unset("KORDEX_TEST_ENV");

console.log(has("KORDEX_TEST_ENV"));
```

Run:

```bash
kordex run main.js --allow-env
```

Output shape:

```txt
true
true
true
works
false
```

### Process access

```js
import { cwd, chdir, run } from "kordex:process";

console.log(cwd());

chdir("/tmp");

console.log(cwd());
console.log(run("true"));
```

Run:

```bash
kordex run main.js --allow-process
```

Output shape:

```txt
/path/where/you-started
/tmp
0
```

### HTTP helpers

`kordex:http` currently provides HTTP helper utilities, not real network requests.

```js
import {
  GET,
  POST,
  isSuccess,
  isRedirect,
  isClientError,
  isServerError,
  statusText,
  buildUrl,
  normalizeMethod,
  isMethod,
} from "kordex:http";

console.log(GET);
console.log(POST);

console.log(isSuccess(200));
console.log(isRedirect(302));
console.log(isClientError(404));
console.log(isServerError(500));

console.log(statusText(200));
console.log(statusText(404));

console.log(buildUrl("https://example.com/", "/api/users"));
console.log(normalizeMethod("post"));
console.log(isMethod("PATCH"));
console.log(isMethod("CUSTOM"));
```

Run:

```bash
kordex run main.js --allow-net
```

Output:

```txt
GET
POST
true
true
true
true
OK
Not Found
https://example.com/api/users
POST
true
false
```

## Check exports

You can inspect a module:

```js
import * as path from "kordex:path";

console.log(Object.keys(path).sort().join(", "));
```

Run:

```bash
kordex run main.js
```

Output:

```txt
basename, dirname, extension, isAbsolute, isRelative, join, name, namespace, normalize, separator
```

## Create a Kordex project

```bash
kordex init app
cd app
```

Run the default entry:

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

## Project configuration

Kordex looks for:

```txt
kordex.json
package.json
```

Example `kordex.json`:

```json
{
  "name": "my-app",
  "version": "0.1.0",
  "entry": "src/main.ts",
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

## Build scripts

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

Generate a source map:

```bash
kordex build . --project --source-map --force
```

Output:

```txt
dist/main.js
dist/main.js.map
```

## REPL

Evaluate code:

```bash
kordex repl --eval "1 + 2"
```

Output:

```txt
3
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

The current package workflow generates and updates:

```txt
kordex.lock
```

This is still an MVP. It resolves declared packages and lock metadata without automatically executing downloaded code.

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

## Architecture

Kordex follows a layered architecture:

```txt
CLI
-> Runtime options
-> Permission bridge
-> Bindings engine
-> Module loader
-> TypeScript loader
-> QuickJS backend
-> Standard native modules
-> ScriptResult
```

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

```txt
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
```

## Build pipeline

For:

```bash
kordex build . --project
```

The pipeline is:

```txt
ProjectDiscovery
-> resolve entry
-> load script
-> analyze import graph
-> transform TypeScript
-> resolve JSON modules
-> bundle modules
-> write dist/main.js
-> optionally write dist/main.js.map
```

## Modules

### `modules/runtime`

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

### `modules/bindings`

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

### `modules/std`

Standard native modules exposed to scripts.

Provides:

- `kordex:console`
- `kordex:path`
- `kordex:fs`
- `kordex:env`
- `kordex:process`
- `kordex:timer`
- `kordex:crypto`
- `kordex:http`

### `modules/cli`

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

## Build from source

Development build:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON
```

Build with tests:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_BUILD_TESTS=ON
```

Run tests:

```bash
vix tests -- --output-on-failure
```

## Test checklist

Use this checklist when validating the runtime:

```txt
global console
kordex:console
kordex:path
kordex:timer
kordex:crypto
kordex:fs with --allow-fs
kordex:env with --allow-env
kordex:process with --allow-process
kordex:http with --allow-net
relative imports
extension resolution
JSON imports
TypeScript loading
build output
project entry
```

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

## Design philosophy

Kordex should stay:

```txt
small
modular
local-first
permission-aware
embeddable
reliable by design
easy to test
safe by default
```

The runtime should expose native capabilities only when the application explicitly asks for them.

## License

MIT License.
