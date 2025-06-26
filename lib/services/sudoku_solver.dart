class SudokuSolver {
  static List<List<int>> solve(List<List<int>> board) {
    List<List<int>> solvedBoard = board.map((List<int> row) => List<int>.from(row)).toList();
    _solveSudoku(solvedBoard);
    return solvedBoard;
  }

  static bool _solveSudoku(List<List<int>> board) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          for (int num = 1; num <= 9; num++) {
            if (_isValid(board, row, col, num)) {
              board[row][col] = num;
              if (_solveSudoku(board)) {
                return true;
              } else {
                board[row][col] = 0; // Backtrack
              }
            }
          }
          return false; // No valid number found
        }
      }
    }
    return true; // Board solved
  }

  static bool _isValid(List<List<int>> board, int row, int col, int num) {
    // Check row
    for (int x = 0; x < 9; x++) {
      if (board[row][x] == num) {
        return false;
      }
    }

    // Check column
    for (int x = 0; x < 9; x++) {
      if (board[x][col] == num) {
        return false;
      }
    }

    // Check 3x3 box
    int startRow = row - row % 3;
    int startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i + startRow][j + startCol] == num) {
          return false;
        }
      }
    }
    return true;
  }
}
