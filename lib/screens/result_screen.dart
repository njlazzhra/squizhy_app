import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/score_card.dart';
import 'quiz_report_screen.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  void _playAgain(BuildContext context) {
    context.read<QuizProvider>().restartQuiz();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final percentage = (quiz.score / quiz.totalQuestions * 100).round();

    final message = percentage >= 80
        ? 'Amazing work!'
        : percentage >= 50
        ? 'Good effort!'
        : 'Keep practicing!';

    final displayName =
    quiz.userName.isNotEmpty ? quiz.userName : 'Quiz Challenger';

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(context.w(0.045)),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _playAgain(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.all(context.w(0.06)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: context.h(0.015)),
                              Image.asset(
                                'assets/images/trophy_illustration.png',
                                height: context.h(0.2),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: context.h(0.025)),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                  color: AppColors.burgundy,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: context.h(0.01)),
                              Text(
                                'Great job, $displayName! You completed the "${quiz.selectedCategory}" quiz.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              SizedBox(height: context.h(0.03)),
                              ScoreCard(
                                score: quiz.score,
                                totalQuestions: quiz.totalQuestions,
                                percentage: percentage,
                              ),
                              SizedBox(height: context.h(0.02)),
                              Text(
                                'Correct answers: ${quiz.score}\n'
                                    'Incorrect or unanswered: '
                                    '${quiz.totalQuestions - quiz.score}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  height: 1.8,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(height: context.h(0.03)),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => QuizReportScreen(
                                          questions: quiz.activeQuestions,
                                          userAnswers: quiz.selectedAnswers,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.assignment_turned_in_outlined,
                                  ),
                                  label: const Text('View Answer Report'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.burgundy,
                                    side: const BorderSide(
                                      color: AppColors.burgundy,
                                    ),
                                    minimumSize: Size(
                                      double.infinity,
                                      context.buttonHeight,
                                    ),
                                    shape: buttonShape,
                                  ),
                                ),
                              ),
                              SizedBox(height: context.h(0.015)),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => _playAgain(context),
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Play Again'),
                                ),
                              ),
                              SizedBox(height: context.h(0.015)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}