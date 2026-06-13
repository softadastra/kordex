import { now, sleep, unixMs } from "kordex:timer";

const before = now();

sleep(10);

const after = now();

console.log(after >= before);
console.log(unixMs() > 0);
