import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/blocs/answer_resutl_bloc/answer_result_bloc.dart';
import 'package:quiz_game/pages/quiz_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnswerResultBloc>(
            create: (context) =>
                AnswerResultBloc()..add(const LoadAnswerResult()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        routes: {'quiz-page': ((context) => const QuizPage())},
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, 'quiz-page').then((value) {
                context.read<AnswerResultBloc>().add(const ResetAnswerResult());
              }),
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }
}
