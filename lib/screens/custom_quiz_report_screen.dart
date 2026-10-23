import 'package:flutter/material.dart';

import '../models/custom_quiz.dart';
import '../theme/app_colors.dart';

class CustomQuizReportScreen extends StatelessWidget {
  final List<CustomQuestion> questions;
  final List<int?> userAnswers;
  final String quizTitle;

  const CustomQuizReportScreen({
    super.key,
    required this.questions,
    required this.userAnswers,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$quizTitle Report'),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final q = questions[index];
            final selectedIndex = userAnswers[index];
            final isAnswered = selectedIndex != null;
            final isCorrect = isAnswered && selectedIndex == q.correctAnswerIndex;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isCorrect
                                ? Colors.green.withValues(alpha: 0.15)
                                : Colors.red.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isCorrect ? Icons.check_circle : Icons.cancel,
                                size: 14,
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isCorrect ? 'Correct' : 'Incorrect',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isCorrect ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      q.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.burgundy,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your Answer: ${isAnswered ? q.options[selectedIndex] : 'Unanswered'}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                    if (!isCorrect) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Correct Answer: ${q.options[q.correctAnswerIndex]}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                    if (q.explanation.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.cream,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '💡 Explanation: ${q.explanation}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.burgundy,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
