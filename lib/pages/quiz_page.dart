import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/blocs/quiz_bloc/quiz_bloc.dart';
import 'package:quiz_game/blocs/timer_bloc/timer_bloc.dart';
import 'package:quiz_game/models/quiz_model.dart';
import 'package:quiz_game/models/ticker.dart';
import 'package:quiz_game/widgets/timer_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBloc _quizBloc = QuizBloc();
  final TimerBloc _timer = TimerBloc(ticker: const Ticker());

  bool isTimeStart = true;
  int errorCount = 0;
  int correctCount = 0;

  @override
  void initState() {
    _quizBloc.add(GetQuiz());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => _timer,
        child: BlocProvider(
          create: (context) => _quizBloc,
          child: BlocListener<QuizBloc, QuizState>(
            listener: (context, state) {
              if (state is QuizError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                if (state is QuizInitial) {
                  return _buildLoading();
                } else if (state is QuizLoading) {
                  return _buildLoading();
                } else if (state is QuizLoaded) {
                  return _buildQuestion(context, state.quizModel);
                } else if (state is QuizError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildQuestion(BuildContext context, QuizModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                // color: Colors.blue[200],
                ),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Question:'),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text('${model.question}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildInformationField(),
                Flexible(
                  child: BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                    if (isTimeStart) {
                      context
                          .read<TimerBloc>()
                          .add(TimerStarted(state.duration));
                    }

                    return TimerWidget(
                      onComplete: () {},
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                  _buildChoicesField(model.choices!, model.correctAnswer!),
            ),
          ),
          _buildFooterButtonField(context, model.correctAnswer!),
        ],
      ),
    );
  }

  Widget _buildInformationField() {
    return Flexible(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Done: ${errorCount + correctCount}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.done,
              color: Colors.green,
            ),
            Text(': $correctCount'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
            Text(': $errorCount'),
          ],
        )
      ],
    ));
  }

  List<Widget> _buildChoicesField(List<String> choices, String answer) {
    List<Widget> questionsWidget = [];

    return questionsWidget;
  }

  Widget _buildFooterButtonField(BuildContext context, String answer) {
    return Container();
  }
}
