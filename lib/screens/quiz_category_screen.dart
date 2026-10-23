import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import 'quiz_screen.dart';

class QuizCategoryScreen extends StatefulWidget {
  const QuizCategoryScreen({super.key});

  @override
  State<QuizCategoryScreen> createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz(String category) {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name to start the quiz!'),
          backgroundColor: AppColors.burgundy,
        ),
      );
      return;
    }

    final provider = context.read<QuizProvider>();
    provider.setUserName(name);
    provider.setQuizCategory(category);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Quiz Category'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personalize Your Quiz',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your name and pick a category to test your knowledge!',
                style: TextStyle(color: AppColors.secondaryText),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  hintText: 'e.g. Najel',
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.burgundy),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Available Categories',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
              ),
              const SizedBox(height: 16),
              _CategoryCard(
                title: 'Wawasan Umum',
                subtitle: 'General Knowledge, Science, Geography & Tech',
                icon: Icons.public,
                color: AppColors.peach,
                onTap: () => _startQuiz('Wawasan Umum'),
              ),
              const SizedBox(height: 16),
              _CategoryCard(
                title: 'Matematika Dasar',
                subtitle: 'Easy arithmetic, addition, multiplication & division',
                icon: Icons.calculate_outlined,
                color: AppColors.cream,
                onTap: () => _startQuiz('Matematika Dasar'),
              ),
              const SizedBox(height: 16),
              _CategoryCard(
                title: 'Computer Science',
                subtitle: 'Basic programming, OS, HTML & computer basics',
                icon: Icons.code_rounded,
                color: AppColors.dustyRose.withValues(alpha: 0.2),
                onTap: () => _startQuiz('Computer Science'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.burgundy.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.burgundy,
                child: Icon(icon, color: AppColors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.burgundy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.secondaryText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: AppColors.burgundy, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
