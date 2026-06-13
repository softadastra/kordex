# Softadastra

This example shows how to use the `kordex:softadastra` standard module.

Softadastra gives Kordex a local-first storage foundation. The module can open a local store, write values, read values back, check keys, and close the store.

Because this module can create local files and access the Softadastra SDK, it is protected by an explicit runtime permission.

## Run

```bash
kordex run examples/15-softadastra/main.js --allow-softadastra
```

Without the permission, Kordex should reject the import:

```bash
kordex run examples/15-softadastra/main.js
```

Expected error:

```txt
permission denied: module "kordex:softadastra" requires --allow-softadastra
```

## What it does

This example:

- opens a durable Softadastra store
- writes values
- reads values back
- checks if a key exists
- prints the store size
- closes the store

The store file is created under:

```txt
.kordex/data/example-store.wal
```

## Expected output

```txt
Opening Softadastra local store...
runtime: kordex
feature: local-first
has runtime: true
store size: 2
Softadastra store closed.
```

## Why this matters

Most JavaScript runtimes focus on executing JavaScript.

Kordex can go further by connecting JavaScript execution with Softadastra local-first storage. This makes it possible to build applications that keep working locally and prepare for durable or synchronized workflows.
