import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/sudoku_game.dart';
import 'package:myapp/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Game'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Sudoku!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 40),
            _buildDifficultyButton(context, 'Easy', SudokuDifficulty.easy),
            const SizedBox(height: 20),
            _buildDifficultyButton(context, 'Medium', SudokuDifficulty.medium),
            const SizedBox(height: 20),
            _buildDifficultyButton(context, 'Hard', SudokuDifficulty.hard),
            const SizedBox(height: 20),
            _buildDifficultyButton(context, 'Expert', SudokuDifficulty.expert),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String text, SudokuDifficulty difficulty) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<SudokuGame>(context, listen: false).newGame(difficulty);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GameScreen()),
        );
      },
      child: Text(text),
    );
  }
}
