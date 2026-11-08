import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/score_card.dart';
import 'custom_quiz_report_screen.dart';
import 'welcome_screen.dart';

class CustomResultScreen extends StatelessWidget {
  const CustomResultScreen({super.key});

  void _goHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final customQuiz = quiz.activeCustomQuiz;
    if (customQuiz == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Result')),
        body: const Center(child: Text('No quiz found.')),
      );
    }

    final score = quiz.customScore;
    final total = quiz.customTotalQuestions;
    final percentage = total == 0 ? 0 : (score / total * 100).round();

    final message = percentage >= 80
        ? 'Outstanding!'
        : percentage >= 50
        ? 'Good job!'
        : 'Nice try!';

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(context.w(0.045)),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _goHome(context);
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
                              Icon(
                                Icons.military_tech,
                                size: context.w(0.22),
                                color: AppColors.burgundy,
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
                                'You completed "${customQuiz.title}" by ${customQuiz.creatorName}!',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              SizedBox(height: context.h(0.03)),
                              ScoreCard(
                                score: score,
                                totalQuestions: total,
                                percentage: percentage,
                              ),
                              SizedBox(height: context.h(0.02)),
                              Text(
                                'Correct answers: $score\n'
                                    'Incorrect or unanswered: ${total - score}',
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
                                        builder: (_) => CustomQuizReportScreen(
                                          questions: customQuiz.questions,
                                          userAnswers:
                                          quiz.activeCustomSelectedAnswers,
                                          quizTitle: customQuiz.title,
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
                                  onPressed: () => _goHome(context),
                                  icon: const Icon(Icons.home_outlined),
                                  label: const Text('Back to Home'),
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