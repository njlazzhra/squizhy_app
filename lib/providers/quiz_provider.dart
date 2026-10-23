import 'dart:math';
import 'package:flutter/foundation.dart';

import '../data/quiz_question.dart';
import '../models/custom_quiz.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  String _selectedCategory = 'Wawasan Umum';
  List<Question> _activeQuestions = quizQuestions;
  int _currentQuestionIndex = 0;
  late List<int?> _selectedAnswers = List<int?>.filled(
    _activeQuestions.length,
    null,
  );

  // Custom Quizzes Storage & Active Session
  final Map<String, CustomQuiz> _customQuizzes = {};
  CustomQuiz? _activeCustomQuiz;
  int _customCurrentQuestionIndex = 0;
  List<int?> _customSelectedAnswers = [];

  String get userName => _userName;
  String get selectedCategory => _selectedCategory;
  List<Question> get activeQuestions => _activeQuestions;

  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  void setQuizCategory(String category) {
    _selectedCategory = category;
    if (category == 'Matematika Dasar') {
      _activeQuestions = mathQuizQuestions;
    } else if (category == 'Computer Science (Easy)') {
      _activeQuestions = csQuizQuestions;
    } else {
      _activeQuestions = quizQuestions;
    }
    _currentQuestionIndex = 0;
    _selectedAnswers = List<int?>.filled(_activeQuestions.length, null);
    notifyListeners();
  }

  // --- Standard Quiz Getters & Methods ---
  int get currentQuestionIndex => _currentQuestionIndex;
  int get totalQuestions => _activeQuestions.length;
  Question get currentQuestion => _activeQuestions[_currentQuestionIndex];
  List<int?> get selectedAnswers => List<int?>.unmodifiable(_selectedAnswers);
  int? get selectedAnswer => _selectedAnswers[_currentQuestionIndex];
  int get answeredQuestions =>
      _selectedAnswers.where((answer) => answer != null).length;

  int get score {
    int totalCorrect = 0;
    for (int i = 0; i < _activeQuestions.length; i++) {
      if (_selectedAnswers[i] == _activeQuestions[i].correctAnswerIndex) {
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
    _userName = '';
    for (int i = 0; i < _selectedAnswers.length; i++) {
      _selectedAnswers[i] = null;
    }
    _activeCustomQuiz = null;
    notifyListeners();
  }

  // --- Custom Quiz Methods ---
  CustomQuiz? get activeCustomQuiz => _activeCustomQuiz;
  int get customCurrentQuestionIndex => _customCurrentQuestionIndex;
  int get customTotalQuestions => _activeCustomQuiz?.questions.length ?? 0;
  List<int?> get activeCustomSelectedAnswers => List<int?>.unmodifiable(_customSelectedAnswers);
  
  CustomQuestion get customCurrentQuestion =>
      _activeCustomQuiz!.questions[_customCurrentQuestionIndex];

  int? get customSelectedAnswer =>
      _customSelectedAnswers.isNotEmpty ? _customSelectedAnswers[_customCurrentQuestionIndex] : null;

  bool get customHasSelectedAnswer => customSelectedAnswer != null;
  bool get customIsLastQuestion =>
      _customCurrentQuestionIndex == customTotalQuestions - 1;

  double get customProgress =>
      (_customCurrentQuestionIndex + 1) / customTotalQuestions;

  String createCustomQuiz({
    required String title,
    required String creatorName,
    required List<CustomQuestion> questions,
  }) {
    final randomCode = 'SQZ-${1000 + Random().nextInt(9000)}';
    final quiz = CustomQuiz(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      creatorName: creatorName,
      code: randomCode,
      questions: questions,
    );
    _customQuizzes[randomCode] = quiz;
    notifyListeners();
    return randomCode;
  }

  bool loadCustomQuizByCode(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (_customQuizzes.containsKey(cleanCode)) {
      _activeCustomQuiz = _customQuizzes[cleanCode];
      _customCurrentQuestionIndex = 0;
      _customSelectedAnswers = List<int?>.filled(
        _activeCustomQuiz!.questions.length,
        null,
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void selectCustomAnswer(int answerIndex) {
    if (_activeCustomQuiz == null) return;
    if (answerIndex < 0 || answerIndex >= customCurrentQuestion.options.length) {
      return;
    }
    _customSelectedAnswers[_customCurrentQuestionIndex] = answerIndex;
    notifyListeners();
  }

  void nextCustomQuestion() {
    if (!customHasSelectedAnswer || customIsLastQuestion) return;
    _customCurrentQuestionIndex++;
    notifyListeners();
  }

  void previousCustomQuestion() {
    if (_customCurrentQuestionIndex == 0) return;
    _customCurrentQuestionIndex--;
    notifyListeners();
  }

  int get customScore {
    if (_activeCustomQuiz == null) return 0;
    int totalCorrect = 0;
    for (int i = 0; i < _activeCustomQuiz!.questions.length; i++) {
      if (_customSelectedAnswers[i] == _activeCustomQuiz!.questions[i].correctAnswerIndex) {
        totalCorrect++;
      }
    }
    return totalCorrect;
  }
}
