import 'dart:math';
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'What should we call you?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter your name. A random quiz category (General Knowledge, Math, or Computer Science) will be assigned to you!',
                style: TextStyle(color: AppColors.secondaryText, height: 1.5),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  hintText: 'e.g. Najel',
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.burgundy),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
