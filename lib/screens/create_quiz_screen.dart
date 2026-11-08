import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/custom_quiz.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';
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
          SnackBar(
            content: Text(
              'Please complete question ${i + 1} and fill all 4 options.',
            ),
          ),
        );
        return;
      }
    }

    final customQuestions =
    _questions.map((q) => q.toCustomQuestion()).toList();

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
    final sectionStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.burgundy,
    );
    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(context.w(0.04)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Craft Your Quiz'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.w(0.05)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Quiz Details', style: sectionStyle),
                    SizedBox(height: context.h(0.015)),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Quiz Title',
                        hintText: 'Mobile Programming',
                        filled: true,
                        fillColor: AppColors.white,
                        border: fieldBorder,
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter a quiz title'
                          : null,
                    ),
                    SizedBox(height: context.h(0.02)),
                    TextFormField(
                      controller: _creatorController,
                      decoration: InputDecoration(
                        labelText: 'Creator Name',
                        hintText: 'Najel',
                        filled: true,
                        fillColor: AppColors.white,
                        border: fieldBorder,
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter creator name'
                          : null,
                    ),
                    SizedBox(height: context.h(0.035)),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Questions (${_questions.length})',
                            style: sectionStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _addQuestion,
                          icon: const Icon(Icons.add, color: AppColors.burgundy),
                          label: const Text(
                            'Add Question',
                            style: TextStyle(color: AppColors.burgundy),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.h(0.015)),
                    ..._questions.asMap().entries.map((entry) {
                      return _buildQuestionCard(entry.key, entry.value);
                    }),
                    SizedBox(height: context.h(0.03)),
                    ElevatedButton.icon(
                      onPressed: _publishQuiz,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Publish & Generate Code'),
                    ),
                    SizedBox(height: context.h(0.04)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index, _QuestionDraft q) {
    return Card(
      margin: EdgeInsets.only(bottom: context.h(0.025)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.w(0.05)),
      ),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(context.w(0.04)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.burgundy,
                  ),
                ),
                if (_questions.length > 1)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.incorrect,
                    ),
                    tooltip: 'Remove question',
                    onPressed: () => _removeQuestion(index),
                  ),
              ],
            ),
            SizedBox(height: context.h(0.01)),
            TextFormField(
              controller: q.questionController,
              decoration: const InputDecoration(
                labelText: 'Question text',
                filled: true,
                fillColor: AppColors.background,
              ),
              validator: (val) =>
              val == null || val.trim().isEmpty ? 'Required' : null,
            ),
            SizedBox(height: context.h(0.02)),
            const Text(
              'Options (Tap an option badge to set as correct answer):',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: context.h(0.01)),
            ...List.generate(4, (optIndex) {
              final isCorrect = q.correctAnswerIndex == optIndex;
              return Padding(
                padding: EdgeInsets.only(bottom: context.h(0.01)),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          q.correctAnswerIndex = optIndex;
                        });
                      },
                      borderRadius: BorderRadius.circular(context.w(0.03)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.w(0.025),
                          vertical: context.h(0.01),
                        ),
                        decoration: BoxDecoration(
                          color:
                          isCorrect ? AppColors.burgundy : AppColors.cream,
                          borderRadius:
                          BorderRadius.circular(context.w(0.03)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check : Icons.circle_outlined,
                              size: context.w(0.045),
                              color: isCorrect
                                  ? AppColors.white
                                  : AppColors.burgundy,
                            ),
                            SizedBox(width: context.w(0.01)),
                            Text(
                              '${String.fromCharCode(65 + optIndex)}${isCorrect ? ' (Key)' : ''}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isCorrect
                                    ? AppColors.white
                                    : AppColors.burgundy,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: context.w(0.02)),
                    Expanded(
                      child: TextFormField(
                        controller: q.optionControllers[optIndex],
                        decoration: InputDecoration(
                          labelText:
                          'Option ${String.fromCharCode(65 + optIndex)} text',
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
            SizedBox(height: context.h(0.015)),
            TextFormField(
              controller: q.explanationController,
              decoration: const InputDecoration(
                labelText: 'Explanation (Optional)',
                hintText: 'e.g. Why is this the correct answer?',
                filled: true,
                fillColor: AppColors.background,
                isDense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionDraft {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
  List.generate(4, (_) => TextEditingController());
  final TextEditingController explanationController = TextEditingController();
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
      explanation: explanationController.text.trim(),
    );
  }

  void dispose() {
    questionController.dispose();
    for (var c in optionControllers) {
      c.dispose();
    }
    explanationController.dispose();
  }
}