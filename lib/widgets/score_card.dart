import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/responsive.dart';

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
      padding: EdgeInsets.symmetric(
        vertical: context.h(0.03),
        horizontal: context.w(0.05),
      ),
      decoration: BoxDecoration(
        color: AppColors.peach,
        borderRadius: BorderRadius.circular(context.w(0.07)),
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
          SizedBox(height: context.h(0.01)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$score/$totalQuestions',
              style: TextStyle(
                color: AppColors.burgundy,
                fontSize: context.w(0.12),
                fontWeight: FontWeight.w800,
              ),
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