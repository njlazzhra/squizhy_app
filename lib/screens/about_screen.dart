import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Squizhy')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/squizhy_logo.png',
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Make every answer count.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.burgundy,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Squizhy is a simple and playful quiz application '
                'designed to make learning more engaging. Test your '
                'knowledge, explore different topics, and see how '
                'much you know.',
                style: TextStyle(height: 1.7),
              ),
              const SizedBox(height: 28),
              Text(
                'How to Play',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.burgundy,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              const _InstructionTile(
                number: '1',
                title: 'Start the quiz',
                description: 'Tap Start Quiz to begin.',
              ),
              const _InstructionTile(
                number: '2',
                title: 'Choose an answer',
                description: 'Select one option for every question.',
              ),
              const _InstructionTile(
                number: '3',
                title: 'Check your score',
                description: 'Finish the quiz to see your result.',
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Learn something new, one question at a time!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.burgundy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionTile extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _InstructionTile({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.peach,
            foregroundColor: AppColors.burgundy,
            child: Text(
              number,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
