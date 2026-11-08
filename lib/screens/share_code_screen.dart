import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
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
                          children: [
                            Icon(
                              Icons.celebration,
                              size: context.w(0.2),
                              color: AppColors.burgundy,
                            ),
                            SizedBox(height: context.h(0.025)),
                            Text(
                              'Your Quiz is Ready!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.burgundy,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: context.h(0.01)),
                            Text(
                              'Quiz: "$quizTitle"',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.secondaryText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: context.h(0.04)),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(context.w(0.06)),
                              decoration: BoxDecoration(
                                color: AppColors.peach,
                                borderRadius:
                                BorderRadius.circular(context.w(0.06)),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'YOUR QUIZ CODE',
                                    style: TextStyle(
                                      color: AppColors.burgundy,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: context.h(0.02)),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      quizCode,
                                      style: TextStyle(
                                        fontSize: context.w(0.09),
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.burgundy,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: context.h(0.02)),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: quizCode),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Quiz code copied to clipboard!',
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.copy),
                                    label: const Text('Copy Code'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.burgundy,
                                      foregroundColor: AppColors.white,
                                      minimumSize: Size(
                                        context.w(0.4),
                                        context.buttonHeight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: context.h(0.03)),
                            const Text(
                              'Use this code on the "Enter Quiz Code" screen to play this quiz again. The code stays valid while the app is open.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                height: 1.5,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(height: context.h(0.02)),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  final success = context
                                      .read<QuizProvider>()
                                      .loadCustomQuizByCode(quizCode);
                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const CustomQuizScreen(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Test My Quiz Now'),
                              ),
                            ),
                            SizedBox(height: context.h(0.015)),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const WelcomeScreen(),
                                    ),
                                        (route) => false,
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.burgundy,
                                  side: const BorderSide(
                                    color: AppColors.burgundy,
                                  ),
                                  minimumSize: Size(
                                    double.infinity,
                                    context.buttonHeight,
                                  ),
                                ),
                                child: const Text('Back to Home'),
                              ),
                            ),
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