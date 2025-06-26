import 'package:flutter/material.dart';

class SudokuGrid extends StatelessWidget {
  final List<List<int>> board;
  final List<List<bool>> initialBoard;
  final int selectedRow;
  final int selectedCol;
  final Function(int, int) onCellSelected;

  const SudokuGrid({
    super.key,
    required this.board,
    required this.initialBoard,
    required this.selectedRow,
    required this.selectedCol,
    required this.onCellSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 3.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
            childAspectRatio: 1.0,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: 81,
          itemBuilder: (context, index) {
            final row = index ~/ 9;
            final col = index % 9;
            final value = board[row][col];
            final isSelected = row == selectedRow && col == selectedCol;
            final isInitial = initialBoard[row][col];

            Color cellColor = Theme.of(context).colorScheme.onPrimary; // White
            if (isSelected) {
              cellColor = Theme.of(context).primaryColor.withOpacity(0.3); // Light Baby Pink
            } else if (row ~/ 3 != (row + 1) ~/ 3 || col ~/ 3 != (col + 1) ~/ 3) {
              // Highlight 3x3 boxes
              if ((row ~/ 3 + col ~/ 3) % 2 == 0) {
                cellColor = Theme.of(context).colorScheme.secondary.withOpacity(0.5); // Lighter Soft Gray
              }
            }

            Color textColor = Theme.of(context).colorScheme.onSurface; // Charcoal Gray
            if (!isInitial && value != 0 && value != board[row][col]) { // Check against solution for mistakes
              textColor = Colors.red;
            } else if (!isInitial && value != 0) {
              textColor = Theme.of(context).colorScheme.primary; // Baby Pink for user input
            }

            return GestureDetector(
              onTap: () => onCellSelected(row, col),
              child: Container(
                decoration: BoxDecoration(
                  color: cellColor,
                  border: Border.all(
                    color: (row % 3 == 0 && row != 0) || (col % 3 == 0 && col != 0)
                        ? Theme.of(context).primaryColor // Thicker border for 3x3 boxes
                        : Colors.grey.shade300,
                    width: (row % 3 == 0 && row != 0) || (col % 3 == 0 && col != 0) ? 2.0 : 0.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  value == 0 ? '' : value.toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: textColor,
                    fontWeight: isInitial ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
