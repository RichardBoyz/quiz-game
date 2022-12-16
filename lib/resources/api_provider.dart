import 'package:dio/dio.dart';
import 'package:quiz_game/models/quiz_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://opentdb.com/api.php?amount=1';

  Future<QuizModel> fetchQuiz() async {
    try {
      Response response = await _dio.get(_url);
      return QuizModel.fromJson(response.data['results'][0]);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return QuizModel.withError("Data not found / Connection issue");
    }
  }
}
