import { hash, random, randomInt, equals } from "kordex:crypto";

console.log(hash("kordex"));
console.log(random() >= 0);
console.log(random() < 1);
console.log(randomInt(1, 10) >= 1);
console.log(equals("hello", "hello"));
console.log(equals("hello", "world"));
