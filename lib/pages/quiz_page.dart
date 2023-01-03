import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/blocs/answer_resutl_bloc/answer_result_bloc.dart';
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
  String selectedChoice = '';
  bool canSelect = true;
  bool isSelected = false;
  bool isCorrectChoice = false;

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
                _buildInformationField(context),
                Flexible(child: _buildTimerField(context)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChoicesField(
                model.choices!, model.correctAnswer!, context),
          )),
          _buildFooterButtonField(context, model.correctAnswer!),
        ],
      ),
    );
  }

  Widget _buildTimerField(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return BlocBuilder<AnswerResultBloc, AnswerResultState>(
            buildWhen: (previous, current) {
          if (previous is AnswerResultLoaded && current is AnswerResultLoaded) {
            if (previous.answerResult.isSelected == false &&
                current.answerResult.isSelected == true) {
              return true;
            }
          }
          return false;
        }, builder: (context, answerResultState) {
          if (answerResultState is AnswerResultLoaded) {
            if (!answerResultState.answerResult.isSelected) {
              context.read<TimerBloc>().add(TimerStarted(state.duration));
            } else {
              context.read<TimerBloc>().add(const TimerPaused());
            }

            return TimerWidget(
              onComplete: () {
                context.read<AnswerResultBloc>().add(
                      UpdateAnswerResult(
                        answerResultState.answerResult.copyWith(
                            isSelected: true,
                            canSelect: false,
                            incorrectCount: answerResultState
                                    .answerResult.isCorrectChoice
                                ? answerResultState.answerResult.incorrectCount
                                : answerResultState
                                        .answerResult.incorrectCount +
                                    1),
                      ),
                    );
              },
            );
          }
          return const CircularProgressIndicator();
        });
      },
    );
  }

  Widget _buildInformationField(BuildContext context) {
    return Flexible(child: BlocBuilder<AnswerResultBloc, AnswerResultState>(
      builder: (context, state) {
        if (state is AnswerResultLoaded) {
          return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
              Text(
                  'Done: ${state.answerResult.incorrectCount + state.answerResult.correctCount}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.done,
              color: Colors.green,
            ),
                  Text(': ${state.answerResult.correctCount}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
                  Text(': ${state.answerResult.incorrectCount}'),
          ],
        )
      ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    ));
  }

  List<Widget> _buildChoicesField(
      List<String> choices, String answer, BuildContext context) {
    List<Widget> questionsWidget = [];
    for (var i = 0; i < choices.length; i += 1) {
      questionsWidget.add(
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<AnswerResultBloc, AnswerResultState>(
              builder: (context, state) {
                if (state is AnswerResultLoaded) {
                  return GestureDetector(
              onTap: () {
                      if (state.answerResult.canSelect) {
                        context.read<AnswerResultBloc>().add(UpdateAnswerResult(
                            state.answerResult
                                .copyWith(selectedChoice: choices[i])));
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(12),
                        border: _choicesBorder(choices[i], answer, state),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${i + 1}. ${choices[i]}',
                  ),
                ),
              ),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      );
    }

    return questionsWidget;
  }

  Widget _buildFooterButtonField(BuildContext context, String answer) {
    return BlocBuilder<AnswerResultBloc, AnswerResultState>(
      builder: (context, state) {
        if (state is AnswerResultLoaded) {
          return ElevatedButton(
            onPressed: () {
                if (state.answerResult.isSelected) {
                  context.read<AnswerResultBloc>().add(
                        ResetAnswerResultExcludeCount(state.answerResult),
                      );
                  _quizBloc.add(GetQuiz());
                  _timer.add(TimerReset());
                } else {
                  bool isCorrectSelect =
                      state.answerResult.selectedChoice == answer;
                  context.read<AnswerResultBloc>().add(UpdateAnswerResult(
                      state.answerResult.copyWith(
                          canSelect: false,
                          isSelected: true,
                          correctCount: isCorrectSelect
                              ? state.answerResult.correctCount + 1
                              : state.answerResult.correctCount,
                          incorrectCount: isCorrectSelect
                              ? state.answerResult.incorrectCount
                              : state.answerResult.incorrectCount + 1,
                          isCorrectChoice:
                              state.answerResult.selectedChoice == answer)));
                  _timer.add(const TimerPaused());
                }
            },
              child: Text(state.answerResult.isSelected ? 'Next' : 'Confirm'));
        }
        return const CircularProgressIndicator();
            },
          );
  }

  BoxBorder? _choicesBorder(
      String choice, String answer, AnswerResultLoaded state) {
    Color color = Colors.black;
    if (state.answerResult.isSelected) {
      if (choice == answer) {
        color = Colors.green;
      } else if (state.answerResult.selectedChoice == choice &&
          !state.answerResult.isCorrectChoice) {
        color = Colors.red;
      } else {
        return null;
      }
    } else {
      if (state.answerResult.selectedChoice != choice ||
          state.answerResult.selectedChoice == '') {
        return null;
      }
    }

    return Border.all(color: color, width: 5);
  }
}
