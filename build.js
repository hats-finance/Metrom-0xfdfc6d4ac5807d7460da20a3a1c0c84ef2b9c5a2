import { execSync } from "node:child_process";
import {
    appendFileSync,
    mkdirSync,
    readFileSync,
    rmSync,
    writeFileSync,
} from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

function getJsonAsTypescript(json) {
    if (json instanceof Array) {
        return `[${json.map(getJsonAsTypescript).join(", ")}]`;
    } else if (typeof json === "object" && json !== null) {
        const properties = Object.keys(json)
            .map((key) => `${key}: ${getJsonAsTypescript(json[key])}`)
            .join(", ");
        return `{ ${properties} }`;
    } else if (typeof json === "string") {
        return `"${json}"`;
    } else {
        return json;
    }
}

const CURRENT_DIR = dirname(fileURLToPath(import.meta.url));

console.log("Building contracts...");
execSync("forge build", { stdio: "inherit" });

console.log("Removing previous dist folder...");
rmSync(join(CURRENT_DIR, "./dist"), { recursive: true });

console.log("Building library...");
execSync("pnpm tsc", { stdio: "inherit" });

console.log("Bundling ABIs...");

const { abi } = JSON.parse(
    readFileSync(join(CURRENT_DIR, "./out/IMetrom.sol/IMetrom.json")),
);

mkdirSync(join(CURRENT_DIR, "./dist/abis"));

writeFileSync(
    join(CURRENT_DIR, "./dist/abis/Metrom.json"),
    JSON.stringify(abi, undefined, 4),
);
appendFileSync(
    join(CURRENT_DIR, "./dist/index.js"),
    `export const metromAbi = ${getJsonAsTypescript(abi)};\n`,
);
