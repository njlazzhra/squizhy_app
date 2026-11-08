import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import 'about_screen.dart';
import 'create_quiz_screen.dart';
import 'enter_code_screen.dart';
import 'name_input_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(context.w(0.045)),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.all(context.w(0.06)),
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
                            SizedBox(height: context.h(0.01)),
                            Image.asset(
                              'assets/images/squizhy_logo.png',
                              height: context.h(0.12),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: context.h(0.02)),
                            Text(
                              'Make every answer count.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.burgundy,
                              ),
                            ),
                            SizedBox(height: context.h(0.01)),
                            Text(
                              'Choose your quiz mode below.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.secondaryText),
                            ),
                            SizedBox(height: context.h(0.03)),
                            Image.asset(
                              'assets/images/welcome_illustration.png',
                              height: context.h(0.18),
                              fit: BoxFit.contain,
                            ),
                            const Spacer(),
                            SizedBox(height: context.h(0.025)),
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
                            SizedBox(height: context.h(0.015)),
                            // Option 2: Craft Your Own Quiz
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
                                  side: const BorderSide(
                                    color: AppColors.burgundy,
                                    width: 1.5,
                                  ),
                                  minimumSize: Size(
                                    double.infinity,
                                    context.buttonHeight,
                                  ),
                                  shape: buttonShape,
                                ),
                                icon: const Icon(Icons.edit_note_rounded),
                                label: const Text('Craft Your Own Quiz'),
                              ),
                            ),
                            SizedBox(height: context.h(0.015)),
                            // Option 3: Enter Quiz Code
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
                                  minimumSize: Size(
                                    double.infinity,
                                    context.buttonHeight,
                                  ),
                                ),
                                icon: const Icon(Icons.vpn_key_rounded),
                                label: const Text('Enter Quiz Code'),
                              ),
                            ),
                            SizedBox(height: context.h(0.01)),
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
    );
  }
}