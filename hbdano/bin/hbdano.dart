import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dart_console/dart_console.dart';

final console = Console();
final random = Random();

// ANSI escape codes
const String clearScreen = "\x1B[2J\x1B[H";
const String resetCursor = "\x1B[H";
const String hideCursor = "\x1B[?25l";
const String showCursor = "\x1B[?25h";
const List<String> colors = [
  "\x1B[45m", // Magenta background
  "\x1B[46m", // Cyan background
  "\x1B[48;5;208m", // Bright Orange background
  "\x1B[48;5;226m", // Bright Yellow background
  "\x1B[48;5;51m",  // Bright Blue background
  "\x1B[48;5;210m", // Light Pink background
  "\x1B[48;5;172m", // Coral background
  "\x1B[48;5;39m",  // Light Green background
  "\x1B[48;5;28m",  // Dark Green background
  "\x1B[48;5;17m",  // Dark Blue background
  "\x1B[48;5;125m", // Purple background
  "\x1B[48;5;187m", // Light Magenta background
  "\x1B[48;5;5m",   // Dark Magenta background
];

// Move cursor to a specific position
String moveCursor(int row, int col) => "\x1B[${row};${col}H";

// Function to display fireworks animation
Future<void> showFireworks(int i) async {
  stdout.write(hideCursor);
  
  // Dapatkan ukuran terminal dari dart_console
  // final size = console
  int terminalHeight = console.windowHeight;
  int terminalWidth = console.windowWidth;
  int startRow = terminalHeight - 1, positionRow, positionCol;

  const int margin = 3;
  final int maxCol = terminalWidth - margin; // Maximum column position considering margin
  final int minColRow = margin; //
  final int maxRow = terminalHeight - margin;

  // Firework starts from the bottom and moves to the center
  
  if (i == 0)
  {
    positionCol = terminalWidth ~/ 2;
    positionRow = terminalHeight ~/ 2;
  }
  else{
    positionCol = minColRow + random.nextInt(maxCol - minColRow); // random position in terminal width with margin
    positionRow = minColRow + random.nextInt(maxRow - minColRow);
  }

  
  // Animate firework moving up
  for (int row = startRow; row >= positionRow; row--) {
    stdout.write(clearScreen);
    stdout.write(moveCursor(row, positionCol));
    stdout.write("|");
    await Future.delayed(Duration(milliseconds: 200));
  }

  // Explosion

  await Future.delayed(Duration(milliseconds: 200));
  var color = getRandomColor();
  // stdout.write("${color}${clearScreen}${resetCursor}"); // Set background once and don't clear it again

  // Step 1: Small Explosion (Single @ at the center)
  stdout.write(moveCursor(positionRow, positionCol));
  stdout.write("${color}@\x1B[0m");
  await Future.delayed(Duration(milliseconds: 150));

  // Step 2: Medium Explosion (Diamond Pattern)
  stdout.write(moveCursor(positionRow, positionCol));
  stdout.write("${color}@\x1B[0m");

  stdout.write(moveCursor(positionRow - 1, positionCol));
  stdout.write("${color}+ +\x1B[0m");

  stdout.write(moveCursor(positionRow - 2, positionCol - 1));
  stdout.write("${color}*   *\x1B[0m");

  stdout.write(moveCursor(positionRow + 1, positionCol));
  stdout.write("${color}+ +\x1B[0m");

  await Future.delayed(Duration(milliseconds: 150));

  stdout.write("${color}${clearScreen}${resetCursor}"); // Set background once and don't clear it again

  // Step 3: Larger Explosion (Expanded Diamond)
  stdout.write(moveCursor(positionRow, positionCol));
  stdout.write("${color}@\x1B[0m");

  stdout.write(moveCursor(positionRow - 1, positionCol));
  stdout.write("${color}+ +\x1B[0m");

  stdout.write(moveCursor(positionRow - 2, positionCol - 1));
  stdout.write("${color}*   *\x1B[0m");

  stdout.write(moveCursor(positionRow - 3, positionCol - 2));
  stdout.write("${color}o     o\x1B[0m");

  stdout.write(moveCursor(positionRow + 1, positionCol));
  stdout.write("${color}+ +\x1B[0m");

  stdout.write(moveCursor(positionRow + 2, positionCol - 1));
  stdout.write("${color}*   *\x1B[0m");

  stdout.write(moveCursor(positionRow + 3, positionCol - 2));
  stdout.write("${color}o     o\x1B[0m");

  await Future.delayed(Duration(milliseconds: 150));

  // Step 4: Full Explosion (Largest)
  stdout.write(moveCursor(positionRow, positionCol));
  stdout.write("${color}@\x1B[0m");

  stdout.write(moveCursor(positionRow - 1, positionCol));
  stdout.write("${color}+ +\x1B[0m");

  stdout.write(moveCursor(positionRow - 2, positionCol - 1));
  stdout.write("${color}*   *\x1B[0m");

  stdout.write(moveCursor(positionRow - 3, positionCol - 2));
  stdout.write("${color}o     o\x1B[0m");

  stdout.write(moveCursor(positionRow - 4, positionCol - 3));
  stdout.write("${color}x       x\x1B[0m");

  stdout.write(moveCursor(positionRow + 1, positionCol));
  stdout.write("${color}+ +\x1B[0m");

  stdout.write(moveCursor(positionRow + 2, positionCol - 1));
  stdout.write("${color}*   *\x1B[0m");

  stdout.write(moveCursor(positionRow + 3, positionCol - 2));
  stdout.write("${color}o     o\x1B[0m");

  stdout.write(moveCursor(positionRow + 4, positionCol - 3));
  stdout.write("${color}x       x\x1B[0m");

  await Future.delayed(Duration(milliseconds: 200));
  stdout.write(clearScreen);

  await Future.delayed(Duration(milliseconds: 500));
  stdout.write(showCursor); // Show the cursor again
}

Future<void> showHBDANO(int terminalWidth, int terminalHeight) async {
  // Clear screen and set background to default
  stdout.write("\x1B[2J\x1B[0m");

  // Define HBD ANO in a large size using stars
  List<String> hbdano = [
    "H     H  BBBBBB   DDDDD         A     N     N  ******",
    "H     H  B     B  D    D       A A    N N   N  *    *",
    "HHHHHHH  BBBBBB   D     D     AAAAA   N  N  N  *    *",
    "H     H  B     B  D    D     A     A  N   N N  *    *",
    "H     H  BBBBBB   DDDDD     A       A N     N  ******"
  ];

  // Center the text vertically
  int startRow = terminalHeight - 1;
  int positionCol = (terminalWidth ~/ 2) - (hbdano[0].length ~/ 2);

  // Move the text upwards
  for (int row = startRow; row >= 0; row--) {
    stdout.write(clearScreen);
    for (int i = 0; i < hbdano.length; i++) {
      int currentRow = row + i;
      if (currentRow >= 0 && currentRow < terminalHeight) {
        stdout.write(moveCursor(currentRow, positionCol));
        stdout.writeln(hbdano[i]);
      }
    }
    await Future.delayed(Duration(milliseconds: 200));
  }

  // Clear the screen after the animation
  stdout.write("\x1B[2J\x1B[0m");
}


String getRandomColor() {
  return colors[random.nextInt(colors.length)];
}

void main() async {
  stdout.write("Masukkan jumlah perulangan:");
  int? ulang = int.parse(stdin.readLineSync()!); // null safety in name string

  stdout.write(clearScreen);
  for (var i = 0; i < ulang; i++)
  {
    await showFireworks(i);
  }
  await showHBDANO(console.windowWidth, console.windowHeight);
  stdout.write(showCursor);
}
