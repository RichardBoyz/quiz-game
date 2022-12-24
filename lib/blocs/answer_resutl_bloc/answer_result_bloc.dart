import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_game/models/answer_result.dart';

part 'answer_result_event.dart';
part 'answer_result_state.dart';

class AnswerResultBloc extends Bloc<AnswerResultEvent, AnswerResultState> {
  AnswerResultBloc()
      : super(AnswerResultLoaded(answerResult: AnswerResult.answerResult)) {
    on<AnswerResultEvent>((event, emit) {});
    on<LoadAnswerResult>(
      (event, emit) {
        emit(AnswerResultLoaded(answerResult: event.answerResult));
      },
    );
    on<UpdateAnswerResult>(
      (event, emit) {
        emit(
          AnswerResultLoaded(
            answerResult: event.answerResult,
          ),
        );
      },
    );
    on<ResetAnswerResultExcludeCount>(
      (event, emit) {
        print(event.answerResult.correctCount.toString());
        emit(
          AnswerResultLoaded(
            answerResult: AnswerResult(
              canSelect: true,
              correctCount: event.answerResult.correctCount,
              incorrectCount: event.answerResult.incorrectCount,
              isCorrectChoice: false,
              isSelected: false,
              selectedChoice: '',
            ),
          ),
        );
      },
    );
    on<ResetAnswerResult>(
      (event, emit) {
        emit(
          const AnswerResultLoaded(
            answerResult: AnswerResult(
              canSelect: true,
              correctCount: 0,
              incorrectCount: 0,
              isCorrectChoice: false,
              isSelected: false,
              selectedChoice: '',
            ),
          ),
        );
      },
    );
  }
}
