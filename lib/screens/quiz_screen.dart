import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/quiz_option_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> _handleExit(BuildContext context) async {
    final navigator = Navigator.of(context);
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Yakin ingin keluar dari kuis ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Lanjut'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (leave == true) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _handleExit(context);
      },
      child: Consumer<QuizProvider>(
        builder: (context, quiz, child) {
          final question = quiz.currentQuestion;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                quiz.userName.isNotEmpty
                    ? '${quiz.userName}\'s Quiz'
                    : 'Squizhy Quiz',
              ),
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
                                'Question ${quiz.currentQuestionIndex + 1}'
                                    ' of ${quiz.totalQuestions}',
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
                                question.category,
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
                            value: quiz.progress,
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
                                        isSelected: quiz.selectedAnswer == index,
                                        onTap: () => quiz.selectAnswer(index),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: context.h(0.015)),
                        Row(
                          children: [
                            if (quiz.currentQuestionIndex > 0) ...[
                              OutlinedButton(
                                onPressed: quiz.previousQuestion,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.burgundy,
                                  side: const BorderSide(
                                    color: AppColors.burgundy,
                                  ),
                                  minimumSize: Size(
                                    context.w(0.14),
                                    context.h(0.065),
                                  ),
                                ),
                                child: const Icon(Icons.arrow_back),
                              ),
                              SizedBox(width: context.w(0.03)),
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
                                        builder: (_) =>
                                        const ResultScreen(),
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
              ),
            ),
          );
        },
      ),
    );
  }
}