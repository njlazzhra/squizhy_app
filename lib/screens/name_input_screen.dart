import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Name'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'What should we call you?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.burgundy,
                    ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter your name to personalize your quiz experience and view your score on the results screen.',
                style: TextStyle(color: AppColors.secondaryText, height: 1.5),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Your name',
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.burgundy),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: AppColors.dustyRose),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: AppColors.dustyRose.withValues(alpha: 0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: AppColors.burgundy, width: 2),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
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
                    context.read<QuizProvider>().setUserName(name);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                  child: const Text('Continue to Quiz'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
