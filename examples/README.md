# Kordex Examples

This directory contains small, testable Kordex examples.

Each example is designed to be simple enough to read quickly and runnable directly with:

```bash
kordex run <file>
```

Some examples require explicit permissions such as `--allow-fs`, `--allow-env`, `--allow-process`, or `--allow-net`.

## Requirements

Install and verify Kordex first:

```bash
kordex version
kordex help
```

Run examples from the repository root:

```bash
cd /path/to/kordex
```

## Examples

| Example                   | Description                              | Command                                                  |
| ------------------------- | ---------------------------------------- | -------------------------------------------------------- |
| `01-hello`                | Basic JavaScript execution               | `kordex run examples/01-hello/main.js`                   |
| `02-typescript`           | TypeScript type stripping                | `kordex run examples/02-typescript/main.ts`              |
| `03-relative-import`      | Relative imports with explicit extension | `kordex run examples/03-relative-import/main.js`         |
| `04-extension-resolution` | Import without `.js` extension           | `kordex run examples/04-extension-resolution/main.js`    |
| `05-directory-index`      | Directory `index.js` resolution          | `kordex run examples/05-directory-index/main.js`         |
| `06-json-import`          | JSON module import                       | `kordex run examples/06-json-import/main.js`             |
| `07-console`              | Global console and `kordex:console`      | `kordex run examples/07-console/main.js`                 |
| `08-path`                 | Path utilities                           | `kordex run examples/08-path/main.js`                    |
| `09-timer`                | Timer utilities                          | `kordex run examples/09-timer/main.js`                   |
| `10-crypto`               | Crypto utility helpers                   | `kordex run examples/10-crypto/main.js`                  |
| `11-fs`                   | Filesystem helpers                       | `kordex run examples/11-fs/main.js --allow-fs`           |
| `12-env`                  | Environment variable helpers             | `kordex run examples/12-env/main.js --allow-env`         |
| `13-process`              | Process helpers                          | `kordex run examples/13-process/main.js --allow-process` |
| `14-http`                 | HTTP utility helpers                     | `kordex run examples/14-http/main.js --allow-net`        |

## 01 - Hello

Run:

```bash
kordex run examples/01-hello/main.js
```

Expected output:

```txt
Hello from Kordex
```

## 02 - TypeScript

Run:

```bash
kordex run examples/02-typescript/main.ts
```

Expected output:

```txt
Hello from Kordex
```

TypeScript support is currently MVP-level. Kordex strips simple type syntax before sending JavaScript to the engine.

## 03 - Relative import

Run:

```bash
kordex run examples/03-relative-import/main.js
```

Expected output:

```txt
Relative import works
```

This validates:

```js
import { message } from "./message.js";
```

## 04 - Extension resolution

Run:

```bash
kordex run examples/04-extension-resolution/main.js
```

Expected output:

```txt
Extension resolution works
```

This validates:

```js
import { message } from "./message";
```

Kordex resolves `./message` to `./message.js`.

## 05 - Directory index resolution

Run:

```bash
kordex run examples/05-directory-index/main.js
```

Expected output:

```txt
Directory index works
```

This validates:

```js
import { name } from "./pkg";
```

Kordex resolves `./pkg` to `./pkg/index.js`.

## 06 - JSON import

Run:

```bash
kordex run examples/06-json-import/main.js
```

Expected output:

```txt
Kordex
runtime
true
```

This validates:

```js
import user from "./user.json";
```

## 07 - Console

Run:

```bash
kordex run examples/07-console/main.js
```

Expected output:

```txt
global console works
[log] log works
[info] info works
[warn] warn works
[error] error works
[debug] debug works
```

This validates:

```js
console.log(...)
```

and:

```js
import { log, info, warn, error, debug } from "kordex:console";
```

## 08 - Path

Run:

```bash
kordex run examples/08-path/main.js
```

Expected output on Linux/macOS:

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

This validates:

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
```

## 09 - Timer

Run:

```bash
kordex run examples/09-timer/main.js
```

Expected output:

```txt
true
true
```

This validates:

```js
import { now, sleep, unixMs } from "kordex:timer";
```

## 10 - Crypto

Run:

```bash
kordex run examples/10-crypto/main.js
```

Expected output shape:

```txt
<hex hash>
true
true
true
true
false
```

This validates:

```js
import { hash, random, randomInt, equals } from "kordex:crypto";
```

## 11 - Filesystem

First run without permission:

```bash
kordex run examples/11-fs/main.js
```

Expected output:

```txt
permission denied: module "kordex:fs" requires --allow-fs
```

Then run with permission:

```bash
kordex run examples/11-fs/main.js --allow-fs
```

Expected output:

```txt
true
true
true
true
Hello from kordex:fs
true
false
```

This validates:

```js
import {
  exists,
  isFile,
  isDirectory,
  writeText,
  readText,
  remove,
} from "kordex:fs";
```

## 12 - Environment

First run without permission:

```bash
kordex run examples/12-env/main.js
```

Expected output:

```txt
permission denied: module "kordex:env" requires --allow-env
```

Then run with permission:

```bash
kordex run examples/12-env/main.js --allow-env
```

Expected output shape:

```txt
true
true
true
works
false
```

This validates:

```js
import { get, has, set, unset } from "kordex:env";
```

## 13 - Process

First run without permission:

```bash
kordex run examples/13-process/main.js
```

Expected output:

```txt
permission denied: module "kordex:process" requires --allow-process
```

Then run with permission:

```bash
kordex run examples/13-process/main.js --allow-process
```

Expected output shape:

```txt
/path/where/you-started
/tmp
0
```

This validates:

```js
import { cwd, chdir, run } from "kordex:process";
```

## 14 - HTTP helpers

First run without permission:

```bash
kordex run examples/14-http/main.js
```

Expected output:

```txt
permission denied: module "kordex:http" requires --allow-net
```

Then run with permission:

```bash
kordex run examples/14-http/main.js --allow-net
```

Expected output:

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

This validates:

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
```

`kordex:http` currently provides HTTP helper utilities. It does not perform real network requests yet.

## Permission model

Kordex keeps sensitive native capabilities behind explicit permissions.

| Module           | Permission        |
| ---------------- | ----------------- |
| `kordex:fs`      | `--allow-fs`      |
| `kordex:env`     | `--allow-env`     |
| `kordex:process` | `--allow-process` |
| `kordex:http`    | `--allow-net`     |

Safe modules can run without extra permissions:

```txt
kordex:console
kordex:path
kordex:timer
kordex:crypto
```

## Run all examples manually

```bash
kordex run examples/01-hello/main.js
kordex run examples/02-typescript/main.ts
kordex run examples/03-relative-import/main.js
kordex run examples/04-extension-resolution/main.js
kordex run examples/05-directory-index/main.js
kordex run examples/06-json-import/main.js
kordex run examples/07-console/main.js
kordex run examples/08-path/main.js
kordex run examples/09-timer/main.js
kordex run examples/10-crypto/main.js
kordex run examples/11-fs/main.js --allow-fs
kordex run examples/12-env/main.js --allow-env
kordex run examples/13-process/main.js --allow-process
kordex run examples/14-http/main.js --allow-net
```

## Notes

Kordex is early-stage.

These examples are intentionally small because they validate the core runtime workflow:

```txt
JavaScript execution
TypeScript loading
relative imports
extension resolution
directory index resolution
JSON imports
standard native modules
permission-gated modules
QuickJS execution
```
