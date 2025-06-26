import 'dart:math';
import 'package:myapp/models/sudoku_game.dart';
import 'package:myapp/services/sudoku_solver.dart';

class SudokuGenerator {
  static List<List<int>> generate(SudokuDifficulty difficulty) {
    List<List<int>> board = List.generate(9, (_) => List.generate(9, (_) => 0));
    _fillDiagonalBoxes(board);
    SudokuSolver.solve(board); // Solve the filled diagonal board to get a complete solution

    int cellsToRemove = _getCellsToRemove(difficulty);
    _removeCells(board, cellsToRemove);

    return board;
  }

  static void _fillDiagonalBoxes(List<List<int>> board) {
    for (int i = 0; i < 9; i += 3) {
      _fillBox(board, i, i);
    }
  }

  static void _fillBox(List<List<int>> board, int row, int col) {
    List<int> numbers = List.generate(9, (index) => index + 1)..shuffle();
    int k = 0;
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        board[row + r][col + c] = numbers[k++];
      }
    }
  }

  static int _getCellsToRemove(SudokuDifficulty difficulty) {
    switch (difficulty) {
      case SudokuDifficulty.easy:
        return 40; // Example: Remove 40 cells for easy
      case SudokuDifficulty.medium:
        return 50; // Example: Remove 50 cells for medium
      case SudokuDifficulty.hard:
        return 55; // Example: Remove 55 cells for hard
      case SudokuDifficulty.expert:
        return 60; // Example: Remove 60 cells for expert
      default:
        return 45;
    }
  }

  static void _removeCells(List<List<int>> board, int count) {
    Random random = Random();
    int removed = 0;
    while (removed < count) {
      int row = random.nextInt(9);
      int col = random.nextInt(9);
      if (board[row][col] != 0) {
        int temp = board[row][col];
        board[row][col] = 0;
        // To ensure unique solution, we would need a more complex check here.
        // For simplicity, we're not checking for unique solutions after removal.
        removed++;
      }
    }
  }
}
