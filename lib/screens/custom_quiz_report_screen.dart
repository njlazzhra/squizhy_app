import 'package:flutter/material.dart';

import '../models/custom_quiz.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

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
        title: Text(
          '$quizTitle Report',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
            child: ListView.builder(
              padding: EdgeInsets.all(context.w(0.05)),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];
                final selectedIndex = userAnswers[index];
                final isAnswered = selectedIndex != null;
                final isCorrect =
                    isAnswered && selectedIndex == q.correctAnswerIndex;
                final statusColor =
                isCorrect ? AppColors.correct : AppColors.incorrect;

                return Card(
                  margin: EdgeInsets.only(bottom: context.h(0.02)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w(0.05)),
                  ),
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.all(context.w(0.04)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Question ${index + 1}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryText,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: context.w(0.02)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.w(0.025),
                                vertical: context.h(0.005),
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.15),
                                borderRadius:
                                BorderRadius.circular(context.w(0.03)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    size: context.w(0.035),
                                    color: statusColor,
                                  ),
                                  SizedBox(width: context.w(0.01)),
                                  Text(
                                    isCorrect ? 'Correct' : 'Incorrect',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.h(0.01)),
                        Text(
                          q.question,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: context.h(0.015)),
                        Text(
                          'Your Answer: ${isAnswered ? q.options[selectedIndex] : 'Unanswered'}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                        if (!isCorrect) ...[
                          SizedBox(height: context.h(0.005)),
                          Text(
                            'Correct Answer: ${q.options[q.correctAnswerIndex]}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.correct,
                            ),
                          ),
                        ],
                        if (q.explanation.isNotEmpty) ...[
                          SizedBox(height: context.h(0.015)),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(context.w(0.03)),
                            decoration: BoxDecoration(
                              color: AppColors.cream,
                              borderRadius:
                              BorderRadius.circular(context.w(0.03)),
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
        ),
      ),
    );
  }
}