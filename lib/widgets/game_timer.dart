import 'package:flutter/material.dart';
import 'dart:async';

class GameTimer extends StatefulWidget {
  final Duration startTime;
  final bool isPaused;
  final Function(Duration) onTimerUpdate;

  const GameTimer({
    super.key,
    required this.startTime,
    required this.isPaused,
    required this.onTimerUpdate,
  });

  @override
  State<GameTimer> createState() => _GameTimerState();
}

class _GameTimerState extends State<GameTimer> {
  late Timer _timer;
  Duration _currentDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _currentDuration = widget.startTime;
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant GameTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused != oldWidget.isPaused) {
      if (widget.isPaused) {
        _timer.cancel();
      } else {
        _startTimer();
      }
    }
    if (widget.startTime != oldWidget.startTime) {
      _currentDuration = widget.startTime;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!widget.isPaused) {
        setState(() {
          _currentDuration = _currentDuration + const Duration(seconds: 1);
        });
        widget.onTimerUpdate(_currentDuration);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time: ${_formatDuration(_currentDuration)}',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
