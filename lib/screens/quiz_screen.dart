import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/quiz_option_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        final question = quiz.currentQuestion;

        return Scaffold(
          appBar: AppBar(
            title: Text(quiz.userName.isNotEmpty ? '${quiz.userName}\'s Quiz' : 'Squizhy Quiz'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Exit quiz',
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${quiz.currentQuestionIndex + 1}'
                        ' of ${quiz.totalQuestions}',
                        style: const TextStyle(
                          color: AppColors.burgundy,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        question.category,
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: quiz.progress,
                      minHeight: 8,
                      backgroundColor: AppColors.peach,
                      color: AppColors.burgundy,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.question,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.burgundy,
                                ),
                          ),
                          const SizedBox(height: 24),
                          ...List.generate(question.options.length, (index) {
                            final isSelected = quiz.selectedAnswer == index;

                            return QuizOptionCard(
                              optionText: question.options[index],
                              index: index,
                              isSelected: isSelected,
                              onTap: () => quiz.selectAnswer(index),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (quiz.currentQuestionIndex > 0) ...[
                        OutlinedButton(
                          onPressed: quiz.previousQuestion,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.burgundy,
                            side: const BorderSide(color: AppColors.burgundy),
                            minimumSize: const Size(54, 54),
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: !quiz.hasSelectedAnswer
                              ? null
                              : () {
                                  if (quiz.isLastQuestion) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ResultScreen(),
                                      ),
                                    );
                                  } else {
                                    quiz.nextQuestion();
                                  }
                                },
                          child: Text(
                            quiz.isLastQuestion
                                ? 'See Results'
                                : 'Next Question',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
