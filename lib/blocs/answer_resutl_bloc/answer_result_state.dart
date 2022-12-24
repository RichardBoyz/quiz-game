part of 'answer_result_bloc.dart';

abstract class AnswerResultState extends Equatable {
  const AnswerResultState();

  @override
  List<Object> get props => [];
}

class AnswerResultLoading extends AnswerResultState {
  const AnswerResultLoading();
}

class AnswerResultLoaded extends AnswerResultState {
  final AnswerResult answerResult;
  const AnswerResultLoaded(
      {this.answerResult = const AnswerResult(
          canSelect: true,
          isCorrectChoice: false,
          isSelected: false,
          correctCount: 0,
          incorrectCount: 0,
          selectedChoice: '')});
  @override
  // TODO: implement props
  List<Object> get props => [answerResult];
}

class AnswerResultSetting extends AnswerResultState {
  const AnswerResultSetting(AnswerResult answerResult);
}
