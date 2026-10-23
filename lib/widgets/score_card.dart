import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ScoreCard extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int percentage;

  const ScoreCard({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.peach,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Text(
            'YOUR SCORE',
            style: TextStyle(
              color: AppColors.burgundy,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$score/$totalQuestions',
            style: const TextStyle(
              color: AppColors.burgundy,
              fontSize: 48,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            '$percentage% correct',
            style: const TextStyle(
              color: AppColors.burgundy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
