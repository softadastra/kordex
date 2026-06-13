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
