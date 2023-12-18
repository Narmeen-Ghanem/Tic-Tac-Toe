import 'dart:io';
import 'dart:core';
bool iswinner = false;
bool isXturn = true;
int moveCount = 0;

List<String> positions = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> winningcombinations = ['012', '048', '036', '147', '246', '258', '345', '678'];
void main() {
  generateBoard();
  getnextCharacter();
}
//checking a combination is true for a player
bool checkCombination(String combination, String checkFor) {
  //split the numbers in a list of integers
  List<int> numbers = combination.split('').map((item) {
    return int.parse(item);
  }).toList();
  bool match = false;
  for (final item in numbers) {
    if (positions[item] == checkFor) {
      match = true;
    } else {
      match = false;
      break;
    }
  }
  return match;
}
void checkWinner(player) {
  for (final item in winningcombinations) {
    bool combinationValidity = checkCombination(item, player);
    if (combinationValidity == true) {
      print('$player WON!');
      iswinner = true;
      break;
    }
  }
}
//play
void getnextCharacter() {
  //enter the input
  print('Player ${isXturn == true ? "1" : "2"}, please enter the number of the squere where you want to place your ${isXturn == true ? "X" : "O"}');
  int number = int.parse(stdin.readLineSync()!);
  //change the value of selected number in positions
  positions[number - 1] = isXturn ? 'X' : 'O';
  //change player turn
  isXturn = !isXturn;
  //increment move count
  moveCount++;
  if (moveCount == 9) {
    iswinner = true;
    print('WIN!');
  } else {

    //clear the console
    clearScreen();

    //regenerate the board
    generateBoard();
  }
  
  //Check Validity for players, declare winner
  
  checkWinner('X');
  checkWinner('O');

  //call current function again if we don't have a winner
  if (iswinner == false) getnextCharacter();
}
//clear console screen
void clearScreen() {
  if (Platform.isWindows) {
    print(Process.runSync("cls", [], runInShell: true).stdout);
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}
//show current board
void generateBoard() {
  print(' ${positions[0]} | ${positions[1]} | ${positions[2]} ');
  print('---+---+---');
  print(' ${positions[3]} | ${positions[4]} | ${positions[5]} ');
  print('---+---+---');
  print(' ${positions[6]} | ${positions[7]} | ${positions[8]} ');

}
