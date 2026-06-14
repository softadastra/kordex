#!/usr/bin/env node

const { spawnSync } = require("child_process");
const path = require("path");

const platform = process.platform;
const arch = process.arch;

let binary;

if (platform === "linux" && arch === "x64") {
  binary = path.join(__dirname, "..", "native", "linux-x64", "bin", "kordex");
} else {
  console.error(`Kordex does not support ${platform}-${arch} yet.`);
  process.exit(1);
}

const result = spawnSync(binary, process.argv.slice(2), {
  stdio: "inherit",
});

if (result.error) {
  console.error(result.error.message);
  process.exit(1);
}

process.exit(result.status ?? 1);
