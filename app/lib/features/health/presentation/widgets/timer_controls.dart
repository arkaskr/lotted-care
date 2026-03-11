import 'package:flutter/material.dart';

class TimerControls extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onPlayPause;
  final VoidCallback onSkip;
  final bool isPlaying;

  const TimerControls({
    super.key,
    required this.onReset,
    required this.onPlayPause,
    required this.onSkip,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFEAF2F8),
          child: IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF0D1B2A)),
            onPressed: onReset,
          ),
        ),
        const SizedBox(width: 24),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF2ECC71),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2ECC71).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 40,
            ),
            onPressed: onPlayPause,
          ),
        ),
        const SizedBox(width: 24),
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFEAF2F8),
          child: IconButton(
            icon: const Icon(Icons.skip_next_rounded, color: Color(0xFF0D1B2A)),
            onPressed: onSkip,
          ),
        ),
      ],
    );
  }
}
