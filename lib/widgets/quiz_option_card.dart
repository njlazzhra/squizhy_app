import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/responsive.dart';

class QuizOptionCard extends StatelessWidget {
  final String optionText;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const QuizOptionCard({
    super.key,
    required this.optionText,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(context.w(0.045));

    return Padding(
      padding: EdgeInsets.only(bottom: context.w(0.03)),
      child: Material(
        color: isSelected ? AppColors.peach : AppColors.white,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.w(0.04)),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: isSelected
                    ? AppColors.burgundy
                    : AppColors.dustyRose.withValues(alpha: 0.4),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: context.w(0.04),
                  backgroundColor:
                  isSelected ? AppColors.burgundy : AppColors.cream,
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.burgundy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: context.w(0.03)),
                Expanded(
                  child: Text(
                    optionText,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.burgundy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}