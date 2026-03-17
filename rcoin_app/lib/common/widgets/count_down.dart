import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otc_app/app.dart';

class CountDown extends StatefulWidget {
  const CountDown({super.key, required this.seconds, this.changed, this.style});

  final int seconds;
  final TextStyle? style;

  final ValueChanged<int>? changed;

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late int seconds;
  late Timer? timer;

  @override
  void initState() {
    seconds = widget.seconds;
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.changed != null) {
        widget.changed!(seconds);
      }
      if (mounted) {
        setState(() {
          if (seconds > 0) {
            seconds--;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (seconds == 0) {
      return Container();
    }
    return Text(
      formatDuration(Duration(seconds: seconds)),
      style: widget.style,
    );
  }
}
