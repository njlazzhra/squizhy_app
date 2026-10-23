import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/score_card.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final percentage = (quiz.score / quiz.totalQuestions * 100).round();

    final message = percentage >= 80
        ? 'Amazing work!'
        : percentage >= 50
        ? 'Good effort!'
        : 'Keep practicing!';

    final displayName = quiz.userName.isNotEmpty ? quiz.userName : 'Quiz Challenger';

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
                      Image.asset(
                        'assets/images/trophy_illustration.png',
                        height: 160,
                        fit: BoxFit.contain,
                      ),
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
                        'Great job, $displayName! You have completed your Squizhy quiz.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 24),
                      ScoreCard(
                        score: quiz.score,
                        totalQuestions: quiz.totalQuestions,
                        percentage: percentage,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<QuizProvider>().restartQuiz();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WelcomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Play Again'),
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
