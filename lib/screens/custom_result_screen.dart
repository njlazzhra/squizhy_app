import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/score_card.dart';
import 'custom_quiz_report_screen.dart';
import 'welcome_screen.dart';

class CustomResultScreen extends StatelessWidget {
  const CustomResultScreen({super.key});

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
    final percentage = (score / total * 100).round();

    final message = percentage >= 80
        ? 'Outstanding!'
        : percentage >= 50
        ? 'Good job!'
        : 'Nice try!';

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.minHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      const Icon(Icons.military_tech, size: 90, color: AppColors.burgundy),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 8),
                      Text(
                        'You completed "${customQuiz.title}" by ${customQuiz.creatorName}!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 24),
                      ScoreCard(
                        score: score,
                        totalQuestions: total,
                        percentage: percentage,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CustomQuizReportScreen(
                                  questions: customQuiz.questions,
                                  userAnswers: quiz.activeCustomSelectedAnswers,
                                  quizTitle: customQuiz.title,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.assignment_turned_in_outlined),
                          label: const Text('View Answer Report'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.burgundy,
                            side: const BorderSide(color: AppColors.burgundy),
                            minimumSize: const Size(double.infinity, 54),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WelcomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.home_outlined),
                          label: const Text('Back to Home'),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
