#!/bin/bash

createTempfile() {
  mktemp 2>/dev/null || mktemp -t 'mazetest'
}

OUTPUT=$(createTempfile)
EXPECTED=$(createTempfile)

# Test 1: Verify the normal clearance process
testNormalexit() {
  echo "Test 1"
  # Complete feasible maze
  printf "d\ns\nm\nd\nq\n" > input.txt

  ./maze test1.txt < input.txt > "$OUTPUT"
  grep -q "arrive at the destination" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 2: Command-line parameters missing
testMissingargument() {
  echo "Test 1"
  ./maze 2> "$OUTPUT"
  grep -q "command-line parameters missing" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 3: Invalid maze file format
testInvalidmazeFormat() {
  echo "Test 3"