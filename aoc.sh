#!/usr/bin/env bash
set -e

YEAR="$1"
DAY="$2"

if [ -z "$YEAR" ] || [ -z "$DAY" ]; then
  echo "usage: ./aoc.sh <year> <day>"
  exit 1
fi

AOC_SESSION_COOKIE="53616c7465645f5f27f731a855ee1d06ad8f1e55d25d56841556a6ae882019bcc209e07decd1290909b56d068d3447c6239e2b58398700c382db0ac4c749cdae"

DAY_PADDED=$(printf "%02d" "$DAY")
DAY_NO_ZEROS=$(echo "$DAY" | sed 's/^0*//')

INPUT_NAME="${YEAR}${DAY}.txt"

# Download input if missing
if [ ! -f "inputs/$INPUT_NAME" ]; then
  PUZZLE_URL="https://adventofcode.com/${YEAR}/day/${DAY_NO_ZEROS}/input"
  curl "$PUZZLE_URL" \
    -H "cookie: session=${AOC_SESSION_COOKIE}" \
    -o "inputs/${INPUT_NAME}"
fi

dune build
