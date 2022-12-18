import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/models/quiz_model.dart';
import 'package:quiz_game/resources/api_repository.dart';
import 'package:equatable/equatable.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    final ApiRepository apiRepository = ApiRepository();
  }
}
