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

BASE="years/y${YEAR}"
INPUT_NAME="${YEAR}${DAY}.txt"

mkdir -p "$BASE"

# Create main.ml if missing
if [ ! -f "$BASE/day${DAY_PADDED}.ml" ]; then
  cat > "$BASE/day${DAY_PADDED}.ml" <<EOF
open Core
open Aoc

let input = In_channel.read_all "inputs/${INPUT_NAME}"

let part1 input =
  input |> String.length

let part2 input =
  input |> String.length

let solve =
  Printf.printf "p1: %d\np2: %d\n"
    (part1 input)
    (part2 input)
EOF
fi

# Download input if missing
if [ ! -f "$BASE/input.txt" ]; then
  PUZZLE_URL="https://adventofcode.com/${YEAR}/day/${DAY_NO_ZEROS}/input"
  curl "$PUZZLE_URL" \
    -H "cookie: session=${AOC_SESSION_COOKIE}" \
    -o "inputs/${INPUT_NAME}"
fi

dune build
