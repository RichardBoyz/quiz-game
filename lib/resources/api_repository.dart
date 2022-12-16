import 'package:quiz_game/models/quiz_model.dart';
import 'package:quiz_game/resources/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();
  Future<QuizModel> fetchQuiz() {
    return _provider.fetchQuiz();
  }
}

class NetworkError extends Error {}
