#!/usr/bin/env node
"use strict";

const fs = require("fs");
const os = require("os");
const path = require("path");

const SOURCE_DIR = path.join(__dirname, "..", "skills");
const TARGET_DIR = path.join(os.homedir(), ".claude", "skills");

const LOOP_ORDER = ["spec", "build", "review"];

function main() {
  const skillNames = fs
    .readdirSync(SOURCE_DIR, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .map((entry) => entry.name);

  if (skillNames.length === 0) {
    console.error("No skills found to install.");
    process.exit(1);
  }

  fs.mkdirSync(TARGET_DIR, { recursive: true });

  for (const name of skillNames) {
    const src = path.join(SOURCE_DIR, name);
    const dest = path.join(TARGET_DIR, name);
    const alreadyExisted = fs.existsSync(dest);

    fs.cpSync(src, dest, { recursive: true, force: true });
    console.log(`${alreadyExisted ? "Updated" : "Installed"} /${name} -> ${dest}`);
  }

  console.log("\nDone. Restart Claude Code (or start a new session) to pick up the skills.");

  if (LOOP_ORDER.every((name) => skillNames.includes(name))) {
    console.log(`Run: /${LOOP_ORDER[0]} to start the loop.`);
  }
}

main();
