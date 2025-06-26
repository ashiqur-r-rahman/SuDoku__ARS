import 'package:flutter/material.dart';
import 'package:myapp/services/sudoku_generator.dart';
import 'package:myapp/services/sudoku_solver.dart';

class SudokuGame extends ChangeNotifier {
  List<List<int>> _board = List.generate(9, (_) => List.generate(9, (_) => 0));
  List<List<int>> _solution = List.generate(9, (_) => List.generate(9, (_) => 0));
  List<List<bool>> _initialBoard = List.generate(9, (_) => List.generate(9, (_) => false));
  int _selectedRow = -1;
  int _selectedCol = -1;
  int _mistakes = 0;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;
  bool _isPaused = false;
  bool _isGameOver = false;

  List<List<int>> get board => _board;
  List<List<int>> get solution => _solution;
  List<List<bool>> get initialBoard => _initialBoard;
  int get selectedRow => _selectedRow;
  int get selectedCol => _selectedCol;
  int get mistakes => _mistakes;
  Duration get elapsedTime => _elapsedTime;
  bool get isPaused => _isPaused;
  bool get isGameOver => _isGameOver;

  void newGame(SudokuDifficulty difficulty) {
    _board = SudokuGenerator.generate(difficulty);
    _solution = SudokuSolver.solve(_board.map((row) => List<int>.from(row)).toList());
    _initialBoard = List.generate(9, (r) => List.generate(9, (c) => _board[r][c] != 0));
    _selectedRow = -1;
    _selectedCol = -1;
    _mistakes = 0;
    _startTime = DateTime.now();
    _elapsedTime = Duration.zero;
    _isPaused = false;
    _isGameOver = false;
    notifyListeners();
  }

  void selectCell(int row, int col) {
    if (!_initialBoard[row][col] && !_isGameOver) {
      _selectedRow = row;
      _selectedCol = col;
      notifyListeners();
    }
  }

  void setCellValue(int value) {
    if (_selectedRow != -1 && _selectedCol != -1 && !_isGameOver) {
      if (_initialBoard[_selectedRow][_selectedCol]) {
        return; // Cannot change initial values
      }

      _board[_selectedRow][_selectedCol] = value;

      if (value != 0 && _board[_selectedRow][_selectedCol] != _solution[_selectedRow][_selectedCol]) {
        _mistakes++;
      }

      if (isBoardSolved()) {
        _isGameOver = true;
        // TODO: Implement high score tracking
      }
      notifyListeners();
    }
  }

  bool isBoardSolved() {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (_board[r][c] == 0 || _board[r][c] != _solution[r][c]) {
          return false;
        }
      }
    }
    return true;
  }

  void togglePause() {
    _isPaused = !_isPaused;
    if (_isPaused) {
      // Pause timer
    } else {
      // Resume timer
    }
    notifyListeners();
  }

  void updateElapsedTime(Duration duration) {
    if (!_isPaused && !_isGameOver) {
      _elapsedTime = duration;
      notifyListeners();
    }
  }
}

enum SudokuDifficulty {
  easy,
  medium,
  hard,
  expert,
}
