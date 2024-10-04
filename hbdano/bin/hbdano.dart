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

// utk pindahkan kursor ke posisi tertentu
String moveCursor(int row, int col) => "\x1B[${row};${col}H";

Future<void> showFireworks(int i) async {
  stdout.write(hideCursor);

  int terminalHeight = console.windowHeight;
  int terminalWidth = console.windowWidth;
  int startRow = terminalHeight - 1, positionRow, positionCol;

  const int margin = 3;
  final int maxCol = terminalWidth - margin;
  final int minColRow = margin;
  final int maxRow = terminalHeight - margin;

  // utk acak posisi firework tp yang pertama tetap di tengah
  if (i == 0) {
    positionCol = terminalWidth ~/ 2;
    positionRow = terminalHeight ~/ 2;
  } else {
    positionCol = minColRow + random.nextInt(maxCol - minColRow);
    positionRow = minColRow + random.nextInt(maxRow - minColRow);
  }

  // utk kembang api sblm meledak (dari bawah ke atas)
  for (int row = startRow; row >= positionRow; row--) {
    stdout.write(clearScreen);
    stdout.write(moveCursor(row, positionCol));
    stdout.write("|");
    await Future.delayed(Duration(milliseconds: 200));
  }

  // firework meledak
  await Future.delayed(Duration(milliseconds: 200));
  var color = getRandomColor();

  // pola ledakan
  List<List<String>> explosionPatterns = [
    ["@", "", "", "", "", ""],
    ["+", " +", "", "", "", ""],
    ["*", "   *", "", "", "", ""],
    ["o", "     o", "", "", "", ""],
    ["x", "       x", "", "", "", ""]
  ];

  // loop untuk tampilkan ledakan dari kecil ke besar
  for (int stage = 0; stage < explosionPatterns.length; stage++) {
    if (stage == 0)
      stdout.write("${color}${clearScreen}${resetCursor}");

    for (int offset = 0; offset <= stage; offset++) {
      // bgian atas
        stdout.write(moveCursor(positionRow - offset, positionCol - offset));
        stdout.write("${color}${explosionPatterns[offset][0]}${explosionPatterns[offset][1]}\x1B[0m");
      // bgian bwah
        stdout.write(moveCursor(positionRow + offset, positionCol - offset));
        stdout.write("${color}${explosionPatterns[offset][0]}${explosionPatterns[offset][1]}\x1B[0m");
    }
    await Future.delayed(Duration(milliseconds: 150));
  }

  stdout.write(clearScreen);
  await Future.delayed(Duration(milliseconds: 500));
  stdout.write(showCursor);
}

Future<void> showHBDANO(int terminalWidth, int terminalHeight) async {
  stdout.write(clearScreen);

  // tulisan habede
  List<String> hbdano = [
    "H     H  BBBBBB   DDDDD         A     N     N  ******",
    "H     H  B     B  D    D       A A    N N   N  *    *",
    "HHHHHHH  BBBBBB   D     D     AAAAA   N  N  N  *    *",
    "H     H  B     B  D    D     A     A  N   N N  *    *",
    "H     H  BBBBBB   DDDDD     A       A N     N  ******"
  ];

  // kasih di tengah tulisannya
  int startRow = terminalHeight - 1;
  int positionCol = (terminalWidth ~/ 2) - (hbdano[0].length ~/ 2);

  // kasih gerak dari bawah ke atas
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

  stdout.write(clearScreen);
}

String getRandomColor() { // fungsi utk acak warna
  return colors[random.nextInt(colors.length)];
}

void main() async {
  stdout.write("Masukkan jumlah perulangan: ");
  int? ulang = int.parse(stdin.readLineSync()!);

  stdout.write(clearScreen);
  for (var i = 0; i < ulang; i++)
  {
    await showFireworks(i);
  }
  await showHBDANO(console.windowWidth, console.windowHeight);
  stdout.write(showCursor);
}
