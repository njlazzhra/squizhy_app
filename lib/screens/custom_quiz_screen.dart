import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/exit_quiz_dialog.dart';
import '../widgets/quiz_option_card.dart';
import 'custom_result_screen.dart';

class CustomQuizScreen extends StatelessWidget {
  const CustomQuizScreen({super.key});

  Future<void> _handleExit(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (await confirmExitQuiz(context)) navigator.pop();
  }

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

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) _handleExit(context);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(customQuiz.title),
              leading: IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Exit quiz',
                onPressed: () => _handleExit(context),
              ),
            ),
            body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.all(context.w(0.05)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Question ${quiz.customCurrentQuestionIndex + 1}'
                                    ' of ${quiz.customTotalQuestions}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.burgundy,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: context.w(0.03)),
                            Flexible(
                              child: Text(
                                'By ${customQuiz.creatorName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.h(0.015)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(context.w(0.05)),
                          child: LinearProgressIndicator(
                            value: quiz.customProgress,
                            minHeight: context.h(0.01),
                            backgroundColor: AppColors.peach,
                            color: AppColors.burgundy,
                          ),
                        ),
                        SizedBox(height: context.h(0.033)),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  question.question,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.burgundy,
                                  ),
                                ),
                                SizedBox(height: context.h(0.028)),
                                ...List.generate(question.options.length,
                                        (index) {
                                      return QuizOptionCard(
                                        optionText: question.options[index],
                                        index: index,
                                        isSelected:
                                        quiz.customSelectedAnswer == index,
                                        onTap: () =>
                                            quiz.selectCustomAnswer(index),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: context.h(0.015)),
                        Row(
                          children: [
                            if (quiz.customCurrentQuestionIndex > 0) ...[
                              OutlinedButton(
                                onPressed: quiz.previousCustomQuestion,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.burgundy,
                                  side: const BorderSide(
                                    color: AppColors.burgundy,
                                  ),
                                  minimumSize: Size(
                                    context.w(0.14),
                                    context.buttonHeight,
                                  ),
                                ),
                                child: const Icon(Icons.arrow_back),
                              ),
                              SizedBox(width: context.w(0.03)),
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
                                        builder: (_) =>
                                        const CustomResultScreen(),
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
              ),
            ),
          ),
        );
      },
    );
  }
}