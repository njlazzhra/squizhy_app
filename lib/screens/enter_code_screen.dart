import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Join Custom Quiz',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter the shareable code provided by your teacher or friend to take their custom quiz.',
                style: TextStyle(color: AppColors.secondaryText, height: 1.5),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _codeController,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  labelText: 'Quiz Code',
                  hintText: 'e.g. SQZ-1234',
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: const Icon(Icons.vpn_key_outlined, color: AppColors.burgundy),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
