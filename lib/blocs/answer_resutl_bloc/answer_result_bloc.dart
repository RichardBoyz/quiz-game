import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'answer_result_event.dart';
part 'answer_result_state.dart';

class AnswerResultBloc extends Bloc<AnswerResultEvent, AnswerResultState> {
  AnswerResultBloc() : super(AnswerResultInitial()) {
    on<AnswerResultEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
