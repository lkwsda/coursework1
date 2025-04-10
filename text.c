#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// structure
struct Position {
  int row;
  int col;
};

void loadMaze(const char* filename); 

void printMaze(); 

void movePlayer(char direction);

int main(int argc, char *argv[]){
  if (argc != 2) {
      // Check if the command-line parameters are correct
      printf("Usage: %s <filename>\n", argv[0]); 
      return 1;
  }
  //Load file
  loadMaze(argv[1]);
  //Printing Maze
  printMaze();
  while (1){
    //Move
    movePlayer(input);
    printMaze();
  }
  return 0;
}