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
