import 'package:flutter/material.dart';
import 'dart:async';

class TimeInHourAndMinute extends StatefulWidget {
  @override
  _TimeInHourAndMinuteState createState() => _TimeInHourAndMinuteState();
}

class _TimeInHourAndMinuteState extends State<TimeInHourAndMinute> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeOfDay.minute != TimeOfDay.now().minute) {
        if (mounted) {
          setState(() {
            _timeOfDay = TimeOfDay.now();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _timeOfDay.minute < 10
              ? '${_timeOfDay.hourOfPeriod}:0${_timeOfDay.minute}'
              : '${_timeOfDay.hourOfPeriod}:${_timeOfDay.minute}',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          width: 5,
        ),
        RotatedBox(
          quarterTurns: 3,
          child: Text(_period),
        )
      ],
    );
  }
}
