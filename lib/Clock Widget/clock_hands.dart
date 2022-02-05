import 'dart:math';

import 'package:get/get.dart';
import 'package:stockbit_tes/Clock Widget/hand_hour.dart';
import 'package:stockbit_tes/Clock Widget/hand_minute.dart';
import 'package:stockbit_tes/Clock Widget/hand_second.dart';
import 'package:flutter/material.dart';
import 'package:stockbit_tes/controller/alarm_controller.dart';
import 'package:stockbit_tes/controller/timer_controller.dart';

/// This is clock indicator which contain the hour hand, minute hand, and second hand
class ClockHands extends StatelessWidget {
  final bool isAlarm;

  ClockHands({this.isAlarm = false});

  final timerController = Get.find<TimerController>();
  final alarmController = Get.put(AlarmController());

  //This the equation from the center point of the clock
  //I'm using trigonometry equation to get the degree from localcoordinate which contain dx and dy coordinates
  // After I get the degree, I will decide which degree I should divide of depend on the indicator, is it a hour, or a minutes/second
  // Minute and second has a same behavior.
  _panUpdateHandler(DragUpdateDetails details) {
    if (this.isAlarm) {
      int x = (details.localPosition.dx - 90).ceil();
      int y = (90 - details.localPosition.dy).ceil();
      double tanValue = y / x;
      double radian = atan(tanValue);
      double degress = ((360 - ((radian * 57.2958) + 90)) - 180);
      int value = 0;
      if (alarmController.whichAlarmSet.value == "hour") {
        value = (degress / 30).ceil();
        if (x < 0) value = value + 6;
      } else {
        value = (degress / 6).ceil();
        if (x < 0) value = value + 30;
      }
      alarmController.setAlarm(alarmController.whichAlarmSet.value, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => new AspectRatio(
          aspectRatio: 1.0,
          child: new Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: new Stack(fit: StackFit.expand, children: <Widget>[
                // To draw the hand, I'm using painter to draw the shape of the clock hand
                new CustomPaint(
                  painter: new HourHandPainter(
                    hours: this.isAlarm
                        ? alarmController.alarm.value.hour
                        : timerController.waktu.value.hour,
                    minutes: this.isAlarm
                        ? alarmController.alarm.value.minute
                        : timerController.waktu.value.minute,
                  ),
                ),
                new CustomPaint(
                  painter: new MinuteHandPainter(
                      minutes: this.isAlarm
                          ? alarmController.alarm.value.minute
                          : timerController.waktu.value.minute,
                      seconds: this.isAlarm
                          ? alarmController.alarm.value.second
                          : timerController.waktu.value.second),
                ),
                // I put the gesture detector here because it's the top stack of the widget,
                // which is visible for user to drag
                GestureDetector(
                  onPanUpdate: _panUpdateHandler,
                  child: new CustomPaint(
                    painter: new SecondHandPainter(
                        seconds: this.isAlarm
                            ? alarmController.alarm.value.second
                            : timerController.waktu.value.second),
                  ),
                ),
              ]))),
    );
  }
}
