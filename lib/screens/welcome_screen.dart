import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'about_screen.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AboutScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.info_outline),
                          label: const Text('About'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.burgundy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.asset(
                        'assets/images/squizhy_logo.png',
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Make every answer count.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.burgundy,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your next favorite quiz starts here.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 24),
                      Image.asset(
                        'assets/images/welcome_illustration.png',
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.peach,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Text(
                          'Ready to test your knowledge?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.burgundy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QuizScreen(),
                              ),
                            );
                          },
                          child: const Text('Start Quiz'),
                        ),
                      ),
                      const SizedBox(height: 8),
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
