import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_tes/Clock%20Widget/clock.dart';
import 'package:stockbit_tes/Clock%20Widget/clock_text.dart';
import 'package:stockbit_tes/controller/alarm_controller.dart';
import 'package:stockbit_tes/notification_api.dart';

class SetAlarmPage extends StatelessWidget {
  final alarmController = Get.put(AlarmController());
  DateTime setDateTime() {
    DateTime now = DateTime.now();
    return DateTime(
        now.year,
        now.month,
        now.hour >
                ((alarmController.alarm.value.abbreviations == "AM")
                    ? alarmController.alarm.value.hour
                    : alarmController.alarm.value.hour + 12)
            ? now.day
            : now.hour ==
                        ((alarmController.alarm.value.abbreviations == "AM")
                            ? alarmController.alarm.value.hour
                            : alarmController.alarm.value.hour + 12) &&
                    now.minute >= alarmController.alarm.value.minute &&
                    now.second > 0
                ? now.day
                : now.day,
        (alarmController.alarm.value.abbreviations == "AM")
            ? alarmController.alarm.value.hour
            : alarmController.alarm.value.hour + 12,
        alarmController.alarm.value.minute,
        alarmController.alarm.value.second);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.teal.withOpacity(0.2)),
            ),
            child: Text(
              "Cancel Alarm",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              NotificationApi.cancelAll();
            },
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.teal.withOpacity(0.2)),
            ),
            child: Text(
              "Set Alarm",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              DateTime setTime = setDateTime();
              DateTime timeNow = DateTime.now();
              bool forTomorrow = false;
              if (setTime.isBefore(timeNow)) {
                setTime = setTime.add(Duration(days: 1));
                forTomorrow = true;
              }
              NotificationApi.showNotificationSchedule(
                  title: 'Alarm',
                  body: 'Your alarm is active',
                  forTomorrow: forTomorrow,
                  payload: setTime.toString(),
                  scheduleDate: setTime);
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Alarm",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Radio(
                        value: "hour",
                        groupValue: alarmController.whichAlarmSet.value,
                        onChanged: (String? value) {
                          alarmController.whichAlarmSet(value);
                        },
                      ),
                      new Text(
                        'Hour',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: "minute",
                        groupValue: alarmController.whichAlarmSet.value,
                        onChanged: (String? value) {
                          alarmController.whichAlarmSet(value);
                        },
                      ),
                      new Text(
                        'Minute',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      new Radio(
                        value: "second",
                        groupValue: alarmController.whichAlarmSet.value,
                        onChanged: (String? value) {
                          alarmController.whichAlarmSet(value);
                        },
                      ),
                      new Text(
                        'Second',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                )),
            Obx(
              () => Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Text(
                          "${alarmController.alarm.value.hour.toString().padLeft(2, '0')}:${alarmController.alarm.value.minute.toString().padLeft(2, '0')}:${alarmController.alarm.value.second.toString().padLeft(2, '0')}",
                          style: TextStyle(fontSize: 45),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          focusColor: Colors.red,
                          isDense: true,
                          style: TextStyle(fontSize: 45, color: Colors.black),
                          value: alarmController.alarm.value.abbreviations,
                          items: [
                            "AM",
                            "PM",
                          ].map((value) {
                            return DropdownMenuItem(
                              child: Text(
                                value,
                              ),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            alarmController.setAlarm("abbreviations", value);
                          },
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Clock(
                circleColor: Colors.black,
                clockText: ClockText.arabic,
                isAlarm: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
