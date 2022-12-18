import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/models/ticker.dart';
part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const _duration = 15;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,

        /// we have to specify the initial stage
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerRunInProgress(event.duration));

    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
    emit(TimerRunPause(state.duration));
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }
}
