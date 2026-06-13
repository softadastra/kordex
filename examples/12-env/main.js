import { get, has, set, unset } from "kordex:env";

console.log(has("HOME"));
console.log(get("HOME") !== null);

set("KORDEX_TEST_ENV", "works");

console.log(has("KORDEX_TEST_ENV"));
console.log(get("KORDEX_TEST_ENV"));

unset("KORDEX_TEST_ENV");

console.log(has("KORDEX_TEST_ENV"));
