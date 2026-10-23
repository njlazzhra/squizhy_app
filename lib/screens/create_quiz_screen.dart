import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/custom_quiz.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import 'share_code_screen.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _creatorController = TextEditingController();

  final List<_QuestionDraft> _questions = [
    _QuestionDraft(),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _creatorController.dispose();
    for (var q in _questions) {
      q.dispose();
    }
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(_QuestionDraft());
    });
  }

  void _removeQuestion(int index) {
    if (_questions.length > 1) {
      setState(() {
        _questions[index].dispose();
        _questions.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A quiz must have at least one question.')),
      );
    }
  }

  void _publishQuiz() {
    if (!_formKey.currentState!.validate()) return;

    for (int i = 0; i < _questions.length; i++) {
      if (!_questions[i].isValid()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please complete question ${i + 1} and fill all 4 options.')),
        );
        return;
      }
    }

    final customQuestions = _questions.map((q) => q.toCustomQuestion()).toList();

    final code = context.read<QuizProvider>().createCustomQuiz(
          title: _titleController.text.trim(),
          creatorName: _creatorController.text.trim(),
          questions: customQuestions,
        );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ShareCodeScreen(
          quizCode: code,
          quizTitle: _titleController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Craft Your Quiz'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Quiz Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.burgundy,
                    ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Quiz Title',
                  hintText: 'Mobile Programming',
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter a quiz title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _creatorController,
                decoration: InputDecoration(
                  labelText: 'Creator Name',
                  hintText: 'Najel',
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter creator name' : null,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Questions (${_questions.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.burgundy,
                        ),
                  ),
                  TextButton.icon(
                    onPressed: _addQuestion,
                    icon: const Icon(Icons.add, color: AppColors.burgundy),
                    label: const Text('Add Question', style: TextStyle(color: AppColors.burgundy)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ..._questions.asMap().entries.map((entry) {
                final index = entry.key;
                final q = entry.value;
                return _buildQuestionCard(index, q);
              }),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _publishQuiz,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Publish & Generate Code'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index, _QuestionDraft q) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.burgundy),
                ),
                if (_questions.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _removeQuestion(index),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: q.questionController,
              decoration: const InputDecoration(
                labelText: 'Question text',
                filled: true,
                fillColor: AppColors.background,
              ),
              validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            const Text('Options (Tap an option badge to set as correct answer):', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            ...List.generate(4, (optIndex) {
              final isCorrect = q.correctAnswerIndex == optIndex;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          q.correctAnswerIndex = optIndex;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: isCorrect ? AppColors.burgundy : AppColors.cream,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check : Icons.circle_outlined,
                              size: 16,
                              color: isCorrect ? AppColors.white : AppColors.burgundy,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${String.fromCharCode(65 + optIndex)}${isCorrect ? ' (Key)' : ''}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isCorrect ? AppColors.white : AppColors.burgundy,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: q.optionControllers[optIndex],
                        decoration: InputDecoration(
                          labelText: 'Option ${String.fromCharCode(65 + optIndex)} text',
                          filled: true,
                          fillColor: AppColors.background,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _QuestionDraft {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers = List.generate(4, (_) => TextEditingController());
  int correctAnswerIndex = 0;

  bool isValid() {
    if (questionController.text.trim().isEmpty) return false;
    for (var c in optionControllers) {
      if (c.text.trim().isEmpty) return false;
    }
    return true;
  }

  CustomQuestion toCustomQuestion() {
    return CustomQuestion(
      question: questionController.text.trim(),
      options: optionControllers.map((c) => c.text.trim()).toList(),
      correctAnswerIndex: correctAnswerIndex,
    );
  }

  void dispose() {
    questionController.dispose();
    for (var c in optionControllers) {
      c.dispose();
    }
  }
}
