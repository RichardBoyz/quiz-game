import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/models/quiz_model.dart';
import 'package:quiz_game/resources/api_repository.dart';
import 'package:equatable/equatable.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetQuiz>((event, emit) async {
      try {
        emit(QuizLoading());
        final quiz = await apiRepository.fetchQuiz();
        emit(QuizLoaded(quiz));
        if (quiz.error != null) {
          emit(QuizError(quiz.error));
        }
      } on NetworkError {
        emit(const QuizError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
