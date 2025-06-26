import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/sudoku_game.dart';
import 'package:myapp/widgets/sudoku_grid.dart';
import 'package:myapp/widgets/number_input_pad.dart';
import 'package:myapp/widgets/game_timer.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Game'),
        centerTitle: true,
        actions: [
          Consumer<SudokuGame>(
            builder: (context, game, child) {
              return IconButton(
                icon: Icon(game.isPaused ? Icons.play_arrow : Icons.pause),
                onPressed: () {
                  game.togglePause();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<SudokuGame>(
        builder: (context, game, child) {
          if (game.isGameOver) {
            return _buildGameOverScreen(context, game);
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GameTimer(
                      startTime: game.elapsedTime,
                      isPaused: game.isPaused,
                      onTimerUpdate: (duration) {
                        game.updateElapsedTime(duration);
                      },
                    ),
                    Text('Mistakes: ${game.mistakes}',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SudokuGrid(
                    board: game.board,
                    initialBoard: game.initialBoard,
                    selectedRow: game.selectedRow,
                    selectedCol: game.selectedCol,
                    onCellSelected: game.selectCell,
                  ),
                ),
              ),
              NumberInputPad(
                onNumberSelected: game.setCellValue,
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGameOverScreen(BuildContext context, SudokuGame game) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congratulations!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface, // Mint Green
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'You solved the puzzle in ${game.elapsedTime.inMinutes}m ${game.elapsedTime.inSeconds % 60}s',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Mistakes: ${game.mistakes}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Go back to home screen
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }
}
