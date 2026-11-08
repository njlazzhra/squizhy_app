import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
import 'quiz_screen.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startRandomQuiz() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name to continue!'),
          backgroundColor: AppColors.burgundy,
        ),
      );
      return;
    }

    // Randomly pick one of the 3 categories
    const categories = ['Wawasan Umum', 'Matematika Dasar', 'Computer Science'];
    final randomCategory = categories[Random().nextInt(categories.length)];

    final provider = context.read<QuizProvider>();
    provider.setUserName(name);
    provider.setQuizCategory(randomCategory);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎲 Random Quiz Assigned: $randomCategory!'),
        backgroundColor: AppColors.burgundy,
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Name'),
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
                              'What should we call you?',
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
                              'Enter your name. A random quiz category (General Knowledge, Math, or Computer Science) will be assigned to you!',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: context.h(0.04)),
                            TextField(
                              controller: _nameController,
                              autofocus: true,
                              maxLength: 20,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _startRandomQuiz(),
                              decoration: InputDecoration(
                                labelText: 'Your Name',
                                hintText: 'e.g. Najel',
                                counterText: '',
                                filled: true,
                                fillColor: AppColors.white,
                                prefixIcon: const Icon(
                                  Icons.person_outline,
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
                                onPressed: _startRandomQuiz,
                                child: const Text('Start Random Quiz'),
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