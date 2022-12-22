import 'package:equatable/equatable.dart';

class AnswerResult extends Equatable {
  final int correctCount;
  final int incorrectCount;

  final bool canSelect;
  final bool isCorrectChoice;
  final bool isSelected;

  final String selectedChoice;

  const AnswerResult({
    required this.canSelect,
    required this.correctCount,
    required this.incorrectCount,
    required this.isCorrectChoice,
    required this.isSelected,
    required this.selectedChoice,
  });

  @override
  List<Object?> get props => [
        canSelect,
        correctCount,
        incorrectCount,
        isCorrectChoice,
        isSelected,
        selectedChoice
      ];

  static AnswerResult answerResult = const AnswerResult(
    correctCount: 0,
    incorrectCount: 0,
    canSelect: true,
    isCorrectChoice: false,
    isSelected: false,
    selectedChoice: '',
  );

  AnswerResult copyWith({
    bool? canSelect,
    bool? isSelected,
    bool? isCorrectChoice,
    int? correctCount,
    int? incorrectCount,
    String? selectedChoice,
  }) {
    return AnswerResult(
      canSelect: canSelect ?? this.canSelect,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      isCorrectChoice: isCorrectChoice ?? this.isCorrectChoice,
      isSelected: isSelected ?? this.isSelected,
      selectedChoice: selectedChoice ?? this.selectedChoice,
    );
  }
}
