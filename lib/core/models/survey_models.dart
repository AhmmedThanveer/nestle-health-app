enum QuestionType { radio, text }

class SurveyQuestion {
  final String id;
  final String text;
  final QuestionType type;
  final List<String> options;
  final bool isRequired;

  const SurveyQuestion({
    required this.id,
    required this.text,
    required this.type,
    this.options = const [],
    this.isRequired = true,
  });
}
