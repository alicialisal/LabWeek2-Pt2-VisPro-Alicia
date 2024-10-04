import 'dart:io';

void main() async {
  const String symbol = "*"; // Simbol yang digunakan untuk ledakan
  const String color = "\x1B[44m"; // Warna untuk ledakan
  const int centerRow = 10; // Baris pusat ledakan
  const int centerCol = 20; // Kolom pusat ledakan
  
  // Cetak pola diamond yang lebih besar
  await printDiamond(centerRow, centerCol, 4, symbol, color);
}

// Fungsi untuk mencetak pola diamond
Future<void> printDiamond(int centerRow, int centerCol, int size, String symbol, String color) async {
  stdout.write("\x1B[2J"); // Clear screen
  
  // Loop atas pola diamond
  for (int i = -size; i <= size; i++) {
    int absI = i.abs(); // Nilai absolute untuk membentuk diamond simetris
    
    // Loop untuk mencetak bagian kanan dan kiri
    for (int j = -size; j <= size; j++) {
      if ((j.abs() >= absI) && (j.abs() % 2 == absI % 2)) { // Kondisi untuk formasi '*'
        stdout.write(moveCursor(centerRow + i, centerCol + j));
        stdout.write("${color}${symbol}\x1B[0m");
      }
    }
  }
  
  await Future.delayed(Duration(milliseconds: 150)); // Waktu jeda
}

// Fungsi untuk menggerakkan kursor ke posisi tertentu
String moveCursor(int row, int col) {
  return "\x1B[${row};${col}H"; // Kode untuk memindahkan kursor
}
