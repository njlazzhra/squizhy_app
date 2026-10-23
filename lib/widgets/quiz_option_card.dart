import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isSelected ? AppColors.peach : AppColors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
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
                  radius: 16,
                  backgroundColor: isSelected ? AppColors.burgundy : AppColors.cream,
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.burgundy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    optionText,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.burgundy,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
