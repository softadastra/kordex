# Kordex

Kordex is a JavaScript and TypeScript runtime for reliable local-first applications.

It is built on top of Vix.cpp and Softadastra, with a focus on local execution, explicit permissions, native modules, and offline-ready application foundations.

## Install

```bash
npm install -g kordex
```

## Run

```bash
kordex run main.js
```

## Example

Create `main.js`:

```js
console.log("Hello from Kordex");
```

Run:

```bash
kordex run main.js
```

Output:

```txt
Hello from Kordex
```

## Status

Kordex is early-stage.

Current foundations include:

* JavaScript execution
* TypeScript MVP loading
* local imports
* JSON imports
* native `kordex:` modules
* explicit runtime permissions
* project entry resolution
* build and bundle workflow

## Links

* Repository: https://github.com/softadastra/kordex
* Releases: https://github.com/softadastra/kordex/releases
* Vix.cpp: https://github.com/vixcpp/vix
* Softadastra: https://softadastra.com

## License

MIT
