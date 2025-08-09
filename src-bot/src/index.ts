/**
 * L2 Intent Searcher (skeleton)
 * Loads TOML configs and prints a demo route.
 */
import fs from "fs";
import path from "path";

function load(relative: string) {
  const p = path.join(process.cwd(), "..", "configs", relative);
  return fs.readFileSync(p, "utf8");
}

async function main() {
  const networks = load("networks.toml");
  const pools = load("pools.toml");
  console.log("Loaded networks.toml:\\n", networks.slice(0, 160), "...");
  console.log("Loaded pools.toml:\\n", pools.slice(0, 160), "...");
  console.log("Example route: OP → UNI-V3[WETH/USDC 0.05%] → CURVE[USDC/DAI] → return");
}

main().catch((e) => { console.error(e); process.exit(1); });
