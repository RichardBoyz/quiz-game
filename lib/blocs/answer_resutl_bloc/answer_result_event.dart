part of 'answer_result_bloc.dart';

abstract class AnswerResultEvent extends Equatable {
  const AnswerResultEvent();

  @override
  List<Object> get props => [];
}

class LoadAnswerResult extends AnswerResultEvent {
  final AnswerResult answerResult;
  const LoadAnswerResult(
      {this.answerResult = const AnswerResult(
        canSelect: true,
        correctCount: 0,
        incorrectCount: 0,
        isCorrectChoice: false,
        isSelected: false,
        selectedChoice: '',
      )});

  @override
  // TODO: implement props
  List<Object> get props => [answerResult];
}

class UpdateAnswerResult extends AnswerResultEvent {
  final AnswerResult answerResult;
  const UpdateAnswerResult(this.answerResult);
}

class ResetAnswerResultExcludeCount extends AnswerResultEvent {
  final AnswerResult answerResult;
  const ResetAnswerResultExcludeCount(this.answerResult);
}

class ResetAnswerResult extends AnswerResultEvent {
  const ResetAnswerResult();
}
