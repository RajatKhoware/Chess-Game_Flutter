class Helper {
  static isWhite(int index) {
    int row = index ~/ 8;
    int col = index % 8;
    bool isWhite = (row + col) % 2 == 0;
    return isWhite;
  }

  static isInBoard(int row, int col) {
    return row >= 0 && row < 8 && col >= 0 && col < 8;
  }
}
