import { cwd, chdir, run } from "kordex:process";

console.log(cwd());

chdir("/tmp");

console.log(cwd());
console.log(run("true"));
