#!/usr/bin/env node
/**
 * Cross-platform Python script runner for Claude Code hooks.
 *
 * Detects the correct Python command for the current platform and runs
 * the specified Python script with any additional arguments.
 *
 * Usage: node runner.js <script.py> [args...]
 */

const { spawn, spawnSync } = require("child_process");
const path = require("path");
const os = require("os");

function getPythonCommand() {
  const isWindows = os.platform() === "win32";

  if (isWindows) {
    // Try commands in order of preference for Windows
    const commands = ["python", "py", "python3"];
    for (const cmd of commands) {
      try {
        const result = spawnSync(cmd, ["--version"], {
          encoding: "utf8",
          timeout: 5000,
          windowsHide: true,
        });
        if (
          result.status === 0 &&
          result.stdout &&
          result.stdout.includes("Python 3")
        ) {
          return cmd;
        }
      } catch (e) {
        continue;
      }
    }
    return "python"; // Default fallback
  }

  return "python3"; // Unix default
}

function main() {
  const args = process.argv.slice(2);

  if (args.length === 0) {
    console.error("Usage: node runner.js <script.py> [args...]");
    process.exit(1);
  }

  const scriptPath = args[0];
  const scriptArgs = args.slice(1);
  const pythonCmd = getPythonCommand();

  // Spawn Python process, inheriting stdio for hook I/O
  const child = spawn(pythonCmd, [scriptPath, ...scriptArgs], {
    stdio: "inherit",
    windowsHide: true,
  });

  child.on("error", (err) => {
    console.error(`Failed to run Python: ${err.message}`);
    process.exit(1);
  });

  child.on("close", (code) => {
    process.exit(code || 0);
  });
}

main();
