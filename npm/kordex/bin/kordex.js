#!/usr/bin/env node

const { spawnSync } = require("child_process");

const platform = process.platform;
const arch = process.arch;

let packageName;

if (platform === "linux" && arch === "x64") {
  packageName = "@kordex/linux-x64";
} else {
  console.error(`Kordex does not support ${platform}-${arch} yet.`);
  process.exit(1);
}

let binary;

try {
  const nativePackage = require(packageName);
  binary = nativePackage.binary;
} catch (error) {
  console.error(`Failed to load ${packageName}.`);
  console.error("Try reinstalling Kordex.");
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
