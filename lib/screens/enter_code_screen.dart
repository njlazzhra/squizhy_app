import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import 'custom_quiz_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _joinQuiz() {
    final code = _codeController.text.trim().toUpperCase();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a quiz code.')),
      );
      return;
    }

    final success = context.read<QuizProvider>().loadCustomQuizByCode(code);
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CustomQuizScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid quiz code. Please check and try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Quiz Code'),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: context.h(0.02)),
                            Text(
                              'Join Custom Quiz',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.burgundy,
                              ),
                            ),
                            SizedBox(height: context.h(0.015)),
                            const Text(
                              'Enter the code of a custom quiz that was created in this app to play it.',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: context.h(0.04)),
                            TextField(
                              controller: _codeController,
                              autofocus: true,
                              maxLength: 8,
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _joinQuiz(),
                              decoration: InputDecoration(
                                labelText: 'Quiz Code',
                                hintText: 'e.g. SQZ-1234',
                                counterText: '',
                                filled: true,
                                fillColor: AppColors.white,
                                prefixIcon: const Icon(
                                  Icons.vpn_key_outlined,
                                  color: AppColors.burgundy,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(context.w(0.045)),
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _joinQuiz,
                                child: const Text('Start Quiz'),
                              ),
                            ),
                            SizedBox(height: context.h(0.02)),
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