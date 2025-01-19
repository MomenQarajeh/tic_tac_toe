import 'dart:io';

bool winner = false;
bool isXtern = true;
int moveCount = 0;

List<String> values = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> combinations = [
  '012',
  '048',
  '036',
  '147',
  '258',
  '246',
  '345',
  '678'
];

bool checkCombination(String combination, String checkFor) {
  List<int> numbers = combination.split('').map(int.parse).toList();
  return numbers.every((index) => values[index] == checkFor);
}

void checkWinner(String player) {
  for (final combination in combinations) {
    if (checkCombination(combination, player)) {
      print('$player WON!!!');
      winner = true;
      return; // Exit the loop early if a winner is found
    }
  }
}

void generateGrid() {
  print(' ${values[0]} | ${values[1]} | ${values[2]} ');
  print('---|---|---');
  print(' ${values[3]} | ${values[4]} | ${values[5]} ');
  print('---|---|---');
  print(' ${values[6]} | ${values[7]} | ${values[8]} ');
}

void clearScreen() {
  if (Platform.isWindows) {
    print(Process.runSync("cls", [], runInShell: true).stdout);
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

void getNextCharacter() {
  while (true) {
    print('Choose a number for ${isXtern ? "X" : "O"} (1-9):');
    String? input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) {
      print('Invalid input. Please enter a number.');
      continue;
    }

    int? number = int.tryParse(input);
    if (number == null) {
      print('Invalid input. Please enter a valid integer.');
      continue;
    }

    if (number < 1 || number > 9) {
      print('Invalid input. Please enter a number between 1 and 9.');
      continue;
    }

    int index = number - 1;

    if (values[index] == 'X' || values[index] == 'O') {
      print('This spot is already taken. Choose another number.');
      continue;
    }

    values[index] = isXtern ? 'X' : 'O';
    isXtern = !isXtern;
    moveCount++;
    clearScreen();
    generateGrid();
    checkWinner('X');
    checkWinner('O');

    if (moveCount == 9 && !winner) {
      print('DRAW!');
      winner = true;
    }

    break;
  }
}

void main() {
  generateGrid();
  while (!winner) {
    getNextCharacter();
  }
}
