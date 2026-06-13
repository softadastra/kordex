# Kordex

<table>
  <tr>
    <td valign="top" width="65%">

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
  Kordex is a small JavaScript and TypeScript runtime built on top of
  <b>Vix.cpp</b> and <b>Softadastra</b>.
</p>

<p>
  It is designed for local-first, offline-ready, permission-controlled applications
  where JavaScript code can run close to the system while native capabilities stay explicit.
</p>

<p>
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

Kordex is a JavaScript and TypeScript runtime focused on reliability, local execution, explicit permissions, and local-first application design.

It can run JavaScript and TypeScript files, resolve local imports, load JSON files, expose native standard modules, bundle scripts, and connect JavaScript code to native C++ capabilities.

Kordex is not trying to be another general-purpose Node.js clone.

Kordex is built for a different direction:

```txt
JavaScript that can keep working locally first.
```

That means the runtime is designed around:

- local execution
- offline-ready workflows
- explicit permissions
- native modules written in C++
- durable local storage
- embeddable runtime architecture
- predictable system access
- reliability-first application foundations

## Why Kordex is different

Most JavaScript runtimes focus on online services, server workloads, web tooling, and package ecosystems.

Kordex starts from a different question:

```txt
What if the application must keep working even when the network is unstable or unavailable?
```

This is where Kordex becomes different.

Kordex combines:

- **QuickJS** for JavaScript execution
- **Vix.cpp** for the C++ runtime, build, system, and developer foundation
- **Softadastra** for durable local-first storage, WAL, sync foundations, transport, discovery, and metadata
- **Kordex Std** for native standard modules
- **Kordex CLI** for a small developer-facing workflow

The goal is not only to execute JavaScript.

The goal is to make JavaScript useful for reliable local-first applications.

## Design direction

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

## Quick example

Create `main.js`:

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

Install Vix.cpp first.

### Linux and macOS

```bash
curl -fsSL https://vixcpp.com/install.sh | bash
```

### Windows PowerShell

```powershell
irm https://vixcpp.com/install.ps1 | iex
```

Verify Vix.cpp:

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

Build Kordex with Softadastra support:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_ENABLE_INSTALL=ON \
  -DKORDEX_ENABLE_STD_SOFTADASTRA=ON
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
install  Install project dependencies
update   Update project dependencies
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

Runtime permissions:

```txt
--allow-fs
--allow-env
--allow-net
--allow-process
--allow-softadastra
```

## Run JavaScript

Create `main.js`:

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

Create `main.ts`:

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

Available standard modules:

```txt
kordex:console
kordex:path
kordex:timer
kordex:crypto
kordex:fs
kordex:env
kordex:process
kordex:http
kordex:softadastra
```

Safe utility modules can be available without special permissions:

```txt
kordex:console
kordex:path
kordex:timer
kordex:crypto
```

Sensitive modules are controlled by explicit runtime permissions:

```txt
kordex:fs           -> --allow-fs
kordex:env          -> --allow-env
kordex:process      -> --allow-process
kordex:http         -> --allow-net
kordex:softadastra  -> --allow-softadastra
```

## Permissions

Kordex does not expose sensitive native capabilities silently.

A script must be started with the required permission flag before it can import modules that touch filesystem, environment variables, process execution, network-related helpers, or Softadastra local-first storage.

Example:

```bash
kordex run main.js --allow-fs
```

Without the required permission, Kordex rejects the import.

Example:

```txt
permission denied: module "kordex:softadastra" requires --allow-softadastra
```

This permission model is one of the main design differences between Kordex and traditional JavaScript runtimes.

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

## `kordex:fs`

Filesystem access requires `--allow-fs`.

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

Without `--allow-fs`, `kordex:fs` is not available to the script.

## `kordex:env`

Environment access requires `--allow-env`.

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

## `kordex:process`

Process access requires `--allow-process`.

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

## `kordex:http`

HTTP helpers require `--allow-net`.

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

## `kordex:softadastra`

Softadastra access requires `--allow-softadastra`.

This module is the main reliability difference in Kordex.

It connects JavaScript execution to the Softadastra C++ SDK, giving scripts access to a local-first storage foundation.

Softadastra can be used to open a local store, write values, read values back, check keys, inspect the store size, and close the store.

Create `main.js`:

```js
import * as softadastra from "kordex:softadastra";

console.log("Opening Softadastra local store...");

softadastra.open("durable", "kordex-example", ".kordex/data/example-store.wal");

softadastra.put("runtime", "kordex");
softadastra.put("feature", "local-first");

const runtime = softadastra.get("runtime");
const feature = softadastra.get("feature");

console.log("runtime:", runtime);
console.log("feature:", feature);
console.log("has runtime:", softadastra.contains("runtime"));
console.log("store size:", softadastra.size());

softadastra.close();

console.log("Softadastra store closed.");
```

Run:

```bash
kordex run main.js --allow-softadastra
```

Expected output:

```txt
Opening Softadastra local store...
runtime: kordex
feature: local-first
has runtime: true
store size: 2
Softadastra store closed.
```

Without permission:

```bash
kordex run main.js
```

Expected error:

```txt
permission denied: module "kordex:softadastra" requires --allow-softadastra
```

### Why this matters

Most JavaScript runtimes stop at executing JavaScript and exposing system APIs.

Kordex goes further by connecting JavaScript to a local-first reliability layer.

That means Kordex can become useful for applications where:

- data must be written locally first
- the app must survive unstable networks
- offline mode is not an afterthought
- local state matters
- synchronization can be added later
- system access must stay permission-controlled

This is the long-term difference between Kordex and many other JavaScript runtimes.

## Check module exports

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

## Examples

The repository includes examples under `examples/`.

```txt
01-hello
02-typescript
03-relative-import
04-extension-resolution
05-directory-index
06-json-import
07-console
08-path
09-timer
10-crypto
11-fs
12-env
13-process
14-http
15-softadastra
```

Run an example:

```bash
kordex run examples/01-hello/main.js
```

Run the Softadastra example:

```bash
kordex run examples/15-softadastra/main.js --allow-softadastra
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

Use Softadastra from REPL eval:

```bash
kordex repl --eval "import * as s from 'kordex:softadastra'; console.log(typeof s.open)" --allow-softadastra
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
          "process": false,
          "softadastra": false
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

The bindings layer handles JavaScript engine execution, native module registration, module loading, TypeScript transformation, and JavaScript backend integration.

The std layer exposes native modules through the `kordex:` namespace.

The CLI layer connects everything into a user-facing tool.

## Runtime pipeline

For:

```bash
kordex run src/main.ts --allow-softadastra
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
- permission-aware module loading

### `modules/std`

Standard native modules exposed to scripts.

Provides:

- `kordex:console`
- `kordex:path`
- `kordex:timer`
- `kordex:crypto`
- `kordex:fs`
- `kordex:env`
- `kordex:process`
- `kordex:http`
- `kordex:softadastra`

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

Development build with Softadastra support:

```bash
vix build --preset dev-ninja --build-target all -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_ENABLE_STD_SOFTADASTRA=ON
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
kordex:softadastra with --allow-softadastra
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
- Softadastra standard module
- integration examples

Still planned:

- full TypeScript compiler integration
- package downloads from registry
- real plugin execution
- richer source maps
- package import resolution
- native ES module execution
- object/function value bridge
- deeper Softadastra sync integration
- richer local-first JavaScript APIs

## Roadmap direction

Kordex is moving toward a runtime where JavaScript can be used for reliable local-first applications.

The direction is:

```txt
JavaScript execution
+ explicit native permissions
+ local durable state
+ offline-first behavior
+ optional synchronization
+ embeddable C++ foundation
```

This is the difference Kordex wants to bring.

Not only:

```txt
run JavaScript
```

But:

```txt
run reliable local-first JavaScript applications
```

## Links

- Repository: https://github.com/softadastra/kordex
- Releases: https://github.com/softadastra/kordex/releases
- Issues: https://github.com/softadastra/kordex/issues
- Vix.cpp: https://github.com/vixcpp/vix
- Softadastra: https://softadastra.com
- Softadastra Engine: https://github.com/softadastra/softadastra

## License

MIT License.
