import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'about_screen.dart';
import 'create_quiz_screen.dart';
import 'enter_code_screen.dart';
import 'name_input_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
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
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const AboutScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.info_outline),
                              color: AppColors.burgundy,
                              tooltip: 'About',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Image.asset(
                            'assets/images/squizhy_logo.png',
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Make every answer count.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.burgundy,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Choose your quiz mode below.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppColors.secondaryText),
                          ),
                          const SizedBox(height: 24),
                          Image.asset(
                            'assets/images/welcome_illustration.png',
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          const SizedBox(height: 20),
                          // Option 1: Start Standard Quiz
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const NameInputScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: const Text('Start Standard Quiz'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Option 2: Craft Your Own Quiz (Teacher/Creator)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CreateQuizScreen(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.burgundy,
                                side: const BorderSide(color: AppColors.burgundy, width: 1.5),
                                minimumSize: const Size(double.infinity, 54),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              icon: const Icon(Icons.edit_note_rounded),
                              label: const Text('Craft Your Own Quiz'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Option 3: Enter Quiz Code (Student/Taker)
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const EnterCodeScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.burgundy,
                                minimumSize: const Size(double.infinity, 48),
                              ),
                              icon: const Icon(Icons.vpn_key_rounded),
                              label: const Text('Enter Quiz Code'),
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
        ),
      ),
    );
  }
}
