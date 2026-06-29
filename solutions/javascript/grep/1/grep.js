#!/usr/bin/env node

// The above line is a shebang. On Unix-like operating systems, or environments,
// this will allow the script to be run by node, and thus turn this JavaScript
// file into an executable. In other words, to execute this file, you may run
// the following from your terminal:
//
// ./grep.js args
//
// If you don't have a Unix-like operating system or environment, for example
// Windows without WSL, you can use the following inside a window terminal,
// such as cmd.exe:
//
// node grep.js args
//
// Read more about shebangs here: https://en.wikipedia.org/wiki/Shebang_(Unix)

const fs = require("fs");
const path = require("path");

/**
 * Reads the given file and returns lines.
 *
 * This function works regardless of POSIX (LF) or windows (CRLF) encoding.
 *
 * @param {string} file path to file
 * @returns {string[]} the lines
 */
function readLines(file) {
  const data = fs.readFileSync(path.resolve(file), { encoding: "utf-8" });
  return data.split(/\r?\n/);
}

const VALID_OPTIONS = [
  "n", // add line numbers
  "l", // print file names where pattern is found
  "i", // ignore case
  "v", // reverse files results
  "x", // match entire line
];

const ARGS = process.argv;

//
// This is only a SKELETON file for the 'Grep' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
// This file should *not* export a function. Use ARGS to determine what to grep
// and use console.log(output) to write to the standard output.

ARGS.splice(0, 2);
let flags = ARGS.filter((arg) => arg.startsWith("-"));
let files = ARGS.filter((arg) => arg.endsWith(".txt"));
let patterns = ARGS.filter(
  (arg) => !arg.startsWith("-") && !arg.endsWith(".txt"),
);

for (let file of files) {
  let readFile = readLines(file);

  let lines = [];

  if (flags.includes("-i")) {
    if (flags.includes("-x")) {
      lines = [
        ...readFile.filter((line) =>
          patterns.map((pat) => pat.toLowerCase()).includes(line.toLowerCase()),
        ),
      ];
    } else {
      lines = [
        ...readFile.filter((line) =>
          line.toLowerCase().includes(patterns.map((pat) => pat.toLowerCase())),
        ),
      ];
    }
  } else {
    if (flags.includes("-x")) {
      lines = [...readFile.filter((line) => patterns.includes(line))];
    } else {
      lines = [...readFile.filter((line) => line.includes(patterns))];
    }
  }

  if (flags.includes("-n")) {
    lines = lines.map((line) => `${readFile.indexOf(line) + 1}:${line}`);
  }
  if (flags.includes("-v")) {
    lines = readFile.filter((fileLine) => !lines.includes(fileLine));
  }

  if (flags.includes("-l")) {
    lines = [...new Set(lines.map((line) => (line = file)))];
  } else if (files.length > 1) {
    lines = lines.map((line) => `${file}:${line}`);
  }

  lines.forEach((line) => {
    console.log(line);
  });
}