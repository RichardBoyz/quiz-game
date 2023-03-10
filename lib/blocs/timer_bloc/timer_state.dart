part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  // TODO: implement props
  List<Object?> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(duration) : super(duration);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration);
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration) : super(duration);
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
