class Helper {
  static isWhite(int index) {
    int row = index ~/ 8;
    int col = index % 8;
    bool isWhite = (row + col) % 2 == 0;
    return isWhite;
  }
}
