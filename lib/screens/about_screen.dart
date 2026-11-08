import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/responsive.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Squizhy')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.w(0.06)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/squizhy_logo.png',
                      height: context.h(0.16),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: context.h(0.03)),
                  Text(
                    'Make every answer count.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.burgundy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: context.h(0.015)),
                  const Text(
                    'Squizhy is a simple and playful quiz application '
                        'designed to make learning more engaging. Test your '
                        'knowledge, explore different topics, and see how '
                        'much you know.',
                    style: TextStyle(height: 1.7),
                  ),
                  SizedBox(height: context.h(0.035)),
                  Text(
                    'How to Play',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.burgundy,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: context.h(0.02)),
                  const _InstructionTile(
                    number: '1',
                    title: 'Start the quiz',
                    description: 'Tap Start Standard Quiz to begin.',
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
                  SizedBox(height: context.h(0.03)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.w(0.045)),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(context.w(0.05)),
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
      padding: EdgeInsets.only(bottom: context.h(0.02)),
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
          SizedBox(width: context.w(0.035)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: context.h(0.005)),
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