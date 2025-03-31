import 'dart:async';
import 'package:flutter/material.dart';

class WidgetTimer extends StatefulWidget{
  final int tempsInitial;

  const WidgetTimer(this.tempsInitial, {super.key});

  @override
  WidgetTimerState createState() => WidgetTimerState();
}

class WidgetTimerState extends State<WidgetTimer> {
  Timer? _timer;
  late int _start;

  @override
  void initState() {
    super.initState();
    _start = widget.tempsInitial;
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void pause() {
    _timer?.cancel();
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _start = widget.tempsInitial;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child:
        Text(
          '$minutes:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
    );
  }
}