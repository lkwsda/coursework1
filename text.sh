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
  echo "Test 2"
  ./maze 2> "$OUTPUT"
  grep -q "command-line parameters missing" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 3: Invalid maze file format
testInvalidmazeFormat() {
  echo "Test 3"
  ./maze test3.txt 2> "$OUTPUT"
  grep -q "invalid maze file format" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 4: Out of bounds
testBoundarycollision() {
  echo "Test 4"
  printf "a\n" | ./maze test4.txt > "$OUTPUT"
  grep -q "out of bounds" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 5: Multiple starting points
testMultipleStartpoints() {
  echo "Test 5"
  ./maze test5.txt 2> "$OUTPUT"
  grep -q "multiple starting points" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 6: Invalid move command
testInvalidinput() {
  echo "Test 6"
  printf "z\n" | ./maze any_maze.txt > "$OUTPUT"
  grep -c "invalid move command" "$OUTPUT" | grep -q 3 && echo "success" || echo "fail"
}

# Test 7: Hit the wall
testWallcollision() {
  echo "Test 7"
  printf "d\n" | ./maze test7 .txt > "$OUTPUT"
  grep -q "hit the wall" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 8: Map display function
testMapdisplay() {
  echo "Test 8"
  printf "m\n" | ./maze sample.txt > "$OUTPUT"
  grep -q "X" "$OUTPUT" && \
  grep -q "E" "$OUTPUT" && \
  grep -q "#" "$OUTPUT" && \
  echo "success" || echo "fail"
}

# Test 9: Too small size maze
testToosmallSizemaze() {
  echo "Test 9"
  ./maze bad_maze.txt 2> "$OUTPUT"
  grep -q "size error" "$OUTPUT" && echo "success" || echo "fail"
}

# Test 10: End function
testImmediatequit() {
  echo "Test 10"
  printf "q\n" | ./maze any_maze.txt > "$OUTPUT"
  grep -q "game over" "$OUTPUT" && echo "success" || echo "fail"
}


testNormalexit
testMissingargument
testInvalidmazeFormat
testBoundarycollision
testMultipleStartpoints
testInvalidinput
testWallcollision
testMapdisplay
testToosmallSizemaze
testImmediatequit 