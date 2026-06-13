import * as softadastra from "kordex:softadastra";

console.log("Opening Softadastra local store...");

softadastra.open("durable", "kordex-example", ".kordex/data/example-store.wal");

softadastra.put("runtime", "kordex");
softadastra.put("feature", "local-first");

const runtime = softadastra.get("runtime");
const feature = softadastra.get("feature");

console.log("runtime:", runtime);
console.log("feature:", feature);
console.log("has runtime:", softadastra.contains("runtime"));
console.log("store size:", softadastra.size());

softadastra.close();

console.log("Softadastra store closed.");
