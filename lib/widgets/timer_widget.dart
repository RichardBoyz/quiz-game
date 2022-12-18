import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  // const TimerWidget({super.key});
  const TimerWidget({super.key, required this.onComplete});
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
