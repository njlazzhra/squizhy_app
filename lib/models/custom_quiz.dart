class CustomQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  CustomQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class CustomQuiz {
  final String id;
  final String title;
  final String creatorName;
  final String code;
  final List<CustomQuestion> questions;

  CustomQuiz({
    required this.id,
    required this.title,
    required this.creatorName,
    required this.code,
    required this.questions,
  });
}
