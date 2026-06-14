# Kordex

**Kordex is a JavaScript and TypeScript runtime for reliable local-first applications.**

Kordex is built on top of **Vix.cpp** and **Softadastra**. It is designed for local execution, offline-ready workflows, explicit permissions, native modules, and applications that need to keep working even when the network is unstable.

Kordex is not trying to be another general-purpose Node.js clone.

It is built for a different direction:

```txt
JavaScript that can keep working locally first.
```

## Install

```bash
npm install kordex
```

Run it with `npx`:

```bash
npx kordex --version
```

## Quick start

Create `main.js`:

```js
console.log("Hello from Kordex");
```

Run it:

```bash
npx kordex run main.js
```

Output:

```txt
Hello from Kordex
```

## Run TypeScript

Create `main.ts`:

```ts
const runtime: string = "Kordex";

console.log("Hello from " + runtime);
```

Run it:

```bash
npx kordex run main.ts
```

Output:

```txt
Hello from Kordex
```

TypeScript support is currently MVP-level.

## Why Kordex?

Most JavaScript runtimes focus on online services, server workloads, web tooling, and package ecosystems.

Kordex starts from another question:

```txt
What if the application must keep working even when the network is unstable or unavailable?
```

That is where Kordex is different.

Kordex is designed around:

- local execution
- offline-ready workflows
- explicit permissions
- native modules written in C++
- durable local-first storage foundations
- embeddable runtime architecture
- predictable system access
- reliability-first application design

## Native foundation

Kordex combines:

- **QuickJS** for JavaScript execution
- **Vix.cpp** for the C++ runtime, build, system, and developer foundation
- **Softadastra** for local-first durability foundations
- **Kordex Std** for native standard modules
- **Kordex CLI** for a small developer-facing workflow

The goal is not only to execute JavaScript.

The goal is to make JavaScript useful for reliable local-first applications.

## Standard modules

Kordex exposes native modules through the `kordex:` prefix.

Available modules include:

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

Some modules are safe utility modules. Others require explicit runtime permissions.

## Permissions

Kordex does not expose sensitive native capabilities silently.

Filesystem, environment, process, network, and Softadastra access are controlled with explicit flags:

```txt
--allow-fs
--allow-env
--allow-net
--allow-process
--allow-softadastra
```

Example:

```bash
npx kordex run main.js --allow-fs
```

Without the required permission, Kordex rejects access to sensitive native modules.

Example:

```txt
permission denied: module "kordex:softadastra" requires --allow-softadastra
```

This permission model is one of the main design differences between Kordex and traditional JavaScript runtimes.

## Local imports

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

Run it:

```bash
npx kordex run main.js
```

Output:

```txt
Import works
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

Run it:

```bash
npx kordex run main.js
```

Output:

```txt
Kordex
runtime
```

## `kordex:softadastra`

Softadastra access requires `--allow-softadastra`.

This module connects JavaScript execution to the Softadastra C++ SDK, giving scripts access to a local-first storage foundation.

Example:

```js
import * as softadastra from "kordex:softadastra";

softadastra.open("durable", "kordex-example", ".kordex/data/example-store.wal");

softadastra.put("runtime", "kordex");
softadastra.put("feature", "local-first");

console.log("runtime:", softadastra.get("runtime"));
console.log("feature:", softadastra.get("feature"));
console.log("store size:", softadastra.size());

softadastra.close();
```

Run it:

```bash
npx kordex run main.js --allow-softadastra
```

Kordex can become useful for applications where:

- data must be written locally first
- the app must survive unstable networks
- offline mode is not an afterthought
- local state matters
- synchronization can be added later
- system access must stay permission-controlled

## CLI

```txt
kordex <command> [options] [args]
```

Available commands include:

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

## Package structure

The npm distribution is split into:

```txt
kordex
@softadastra/kordex-linux-x64
```

The `kordex` package is the CLI wrapper.

The `@softadastra/kordex-linux-x64` package contains the Linux x64 native binary.

## Current status

Kordex is early-stage.

Implemented foundations include:

- JavaScript execution
- TypeScript MVP loader
- local imports
- JSON imports
- native `kordex:` modules
- explicit runtime permissions
- project entry resolution
- build and bundle workflow
- Linux x64 npm distribution

Still planned:

- full TypeScript compiler integration
- package downloads from registry
- real plugin execution
- richer source maps
- package import resolution
- native ES module execution
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

MIT
