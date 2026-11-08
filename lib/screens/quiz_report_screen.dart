import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

class QuizReportScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int?> userAnswers;

  const QuizReportScreen({
    super.key,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Answer Report'),
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
                            Flexible(
                              child: Text(
                                'Question ${index + 1} • ${q.category}',
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
                                color: isCorrect
                                    ? Colors.green.withValues(alpha: 0.15)
                                    : Colors.red.withValues(alpha: 0.15),
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
                                    color:
                                    isCorrect ? Colors.green : Colors.red,
                                  ),
                                  SizedBox(width: context.w(0.01)),
                                  Text(
                                    isCorrect ? 'Correct' : 'Incorrect',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color:
                                      isCorrect ? Colors.green : Colors.red,
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
                            color: isCorrect
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                        if (!isCorrect) ...[
                          SizedBox(height: context.h(0.005)),
                          Text(
                            'Correct Answer: ${q.options[q.correctAnswerIndex]}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
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