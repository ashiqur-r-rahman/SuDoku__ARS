import 'package:flutter/material.dart';

class NumberInputPad extends StatelessWidget {
  final Function(int) onNumberSelected;

  const NumberInputPad({
    super.key,
    required this.onNumberSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton(context, 1),
              _buildNumberButton(context, 2),
              _buildNumberButton(context, 3),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton(context, 4),
              _buildNumberButton(context, 5),
              _buildNumberButton(context, 6),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton(context, 7),
              _buildNumberButton(context, 8),
              _buildNumberButton(context, 9),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildClearButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(BuildContext context, int number) {
    return ElevatedButton(
      onPressed: () => onNumberSelected(number),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(60, 60),
        textStyle: Theme.of(context).textTheme.headlineSmall,
      ),
      child: Text(number.toString()),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onNumberSelected(0),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 60),
        textStyle: Theme.of(context).textTheme.headlineSmall,
        backgroundColor: Theme.of(context).colorScheme.secondary, // Soft Gray
        foregroundColor: Theme.of(context).colorScheme.onSurface, // Charcoal Gray
      ),
      child: const Text('Clear'),
    );
  }
}
