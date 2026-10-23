import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/quiz_option_card.dart';
import 'custom_result_screen.dart';

class CustomQuizScreen extends StatelessWidget {
  const CustomQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        final customQuiz = quiz.activeCustomQuiz;
        if (customQuiz == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('No active custom quiz found.')),
          );
        }

        final question = quiz.customCurrentQuestion;

        return Scaffold(
          appBar: AppBar(
            title: Text(customQuiz.title),
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
                        'Question ${quiz.customCurrentQuestionIndex + 1}'
                        ' of ${quiz.customTotalQuestions}',
                        style: const TextStyle(
                          color: AppColors.burgundy,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'By ${customQuiz.creatorName}',
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: quiz.customProgress,
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
                            final isSelected = quiz.customSelectedAnswer == index;

                            return QuizOptionCard(
                              optionText: question.options[index],
                              index: index,
                              isSelected: isSelected,
                              onTap: () => quiz.selectCustomAnswer(index),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (quiz.customCurrentQuestionIndex > 0) ...[
                        OutlinedButton(
                          onPressed: quiz.previousCustomQuestion,
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
                          onPressed: !quiz.customHasSelectedAnswer
                              ? null
                              : () {
                                  if (quiz.customIsLastQuestion) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const CustomResultScreen(),
                                      ),
                                    );
                                  } else {
                                    quiz.nextCustomQuestion();
                                  }
                                },
                          child: Text(
                            quiz.customIsLastQuestion
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
