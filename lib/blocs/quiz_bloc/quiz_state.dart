part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final QuizModel quizModel;
  const QuizLoaded(this.quizModel);
}

class QuizError extends QuizState {
  final String? message;
  const QuizError(this.message);
}
