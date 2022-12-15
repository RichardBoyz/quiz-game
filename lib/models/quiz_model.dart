class QuizModel {
  String? category;
  String? type;
  String? difficulty;
  String? question;
  String? correctAnswer;
  List<dynamic>? incorrectAnswers;
  List<String>? choices;

  String? error;

  QuizModel({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
    this.choices,
  });

  QuizModel.withError(String errorMessage) {
    error = errorMessage;
  }

  QuizModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'];
    if (type == 'boolean') {
      choices = ['true', 'false'];
    } else {
      List<String> questions = List<String>.from(incorrectAnswers!);
      questions.add(correctAnswer!);
      questions.shuffle();
      choices = questions;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['category'] = category;
    data['type'] = type;
    data['difficulty'] = difficulty;
    data['question'] = question;
    data['correct_answer'] = correctAnswer;
    data['incorrect_answers'] = incorrectAnswers;
    data['choices'] = choices;

    return data;
  }
}
