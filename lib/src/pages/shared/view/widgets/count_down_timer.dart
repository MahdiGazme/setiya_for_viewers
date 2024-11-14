import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final Duration duration;
  final TextStyle? textStyle;

  const CountDownTimer({
    required this.duration,
    this.textStyle,
    final Key? key,
  }) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? countdownTimer;
  Duration? remainingDuration;

  @override
  void initState() {
    remainingDuration = widget.duration;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (final _) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = remainingDuration!.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        remainingDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    String strDigits(final int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(remainingDuration!.inHours);
    final minutes = strDigits(remainingDuration!.inMinutes.remainder(60));
    final seconds = strDigits(remainingDuration!.inSeconds.remainder(60));

    return Text(
      '$hours:$minutes:$seconds',
      style: widget.textStyle,
    );
  }
}
