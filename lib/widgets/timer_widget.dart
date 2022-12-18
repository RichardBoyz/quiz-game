import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/blocs/timer_bloc/timer_bloc.dart';

class TimerWidget extends StatelessWidget {
  // const TimerWidget({super.key});
  const TimerWidget({super.key, required this.onComplete});
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    if (context.read<TimerBloc>().state is TimerRunComplete) {
      onComplete();
    }
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                value:
                    (context.select((TimerBloc bloc) => bloc.state.duration) /
                            15)
                        .toDouble(),
              ),
            ),
          ),
          Center(
            child: Text(
              '${context.select((TimerBloc bloc) => bloc.state.duration)}',
            ),
          )
        ],
      ),
    );
  }
}
