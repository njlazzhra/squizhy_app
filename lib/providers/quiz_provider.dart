import 'package:flutter/foundation.dart';

import '../data/quiz_question.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  final List<int?> _selectedAnswers = List<int?>.filled(
    quizQuestions.length,
    null,
  );

  int get currentQuestionIndex => _currentQuestionIndex;

  int get totalQuestions => quizQuestions.length;

  Question get currentQuestion => quizQuestions[_currentQuestionIndex];

  List<int?> get selectedAnswers => List<int?>.unmodifiable(_selectedAnswers);

  int? get selectedAnswer => _selectedAnswers[_currentQuestionIndex];

  int get answeredQuestions =>
      _selectedAnswers.where((answer) => answer != null).length;

  int get score {
    int totalCorrect = 0;

    for (int i = 0; i < quizQuestions.length; i++) {
      if (_selectedAnswers[i] == quizQuestions[i].correctAnswerIndex) {
        totalCorrect++;
      }
    }

    return totalCorrect;
  }

  double get progress => (_currentQuestionIndex + 1) / totalQuestions;

  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;

  bool get hasSelectedAnswer => selectedAnswer != null;

  void selectAnswer(int answerIndex) {
    if (answerIndex < 0 || answerIndex >= currentQuestion.options.length) {
      return;
    }

    _selectedAnswers[_currentQuestionIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (!hasSelectedAnswer || isLastQuestion) return;

    _currentQuestionIndex++;
    notifyListeners();
  }

  void previousQuestion() {
    if (_currentQuestionIndex == 0) return;

    _currentQuestionIndex--;
    notifyListeners();
  }

  void restartQuiz() {
    _currentQuestionIndex = 0;

    for (int i = 0; i < _selectedAnswers.length; i++) {
      _selectedAnswers[i] = null;
    }

    notifyListeners();
  }
}
