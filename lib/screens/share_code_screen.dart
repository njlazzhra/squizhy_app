import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import 'custom_quiz_screen.dart';
import 'welcome_screen.dart';

class ShareCodeScreen extends StatelessWidget {
  final String quizCode;
  final String quizTitle;

  const ShareCodeScreen({
    super.key,
    required this.quizCode,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Created Successfully'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.celebration, size: 80, color: AppColors.burgundy),
              const SizedBox(height: 20),
              Text(
                'Your Quiz is Ready!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Quiz: "$quizTitle"',
                style: const TextStyle(fontSize: 16, color: AppColors.secondaryText),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.peach,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const Text(
                      'SHARE THIS QUIZ CODE',
                      style: TextStyle(
                        color: AppColors.burgundy,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      quizCode,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.burgundy,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: quizCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Quiz code copied to clipboard!')),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy Code'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.burgundy,
                        foregroundColor: AppColors.white,
                        minimumSize: const Size(160, 48),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Share this code with your students or friends so they can enter it on their app and take your quiz.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.secondaryText, height: 1.5),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final success = context.read<QuizProvider>().loadCustomQuizByCode(quizCode);
                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const CustomQuizScreen()),
                      );
                    }
                  },
                  child: const Text('Test My Quiz Now'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.burgundy,
                    side: const BorderSide(color: AppColors.burgundy),
                    minimumSize: const Size(double.infinity, 54),
                  ),
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
