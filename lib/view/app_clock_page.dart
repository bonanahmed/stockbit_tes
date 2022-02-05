import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_tes/Clock%20Widget/clock.dart';
import 'package:stockbit_tes/Clock%20Widget/clock_text.dart';
import 'package:stockbit_tes/controller/timer_controller.dart';

class AppClock extends StatefulWidget {
  @override
  _AppClockState createState() => _AppClockState();
}

class _AppClockState extends State<AppClock> {
  final timerController = Get.put(TimerController());

  @override
  void initState() {
    super.initState();
    timerController.initTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timerController.disposeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: Obx(
                  () => Text(
                    "${timerController.waktu.value.hour.toString().padLeft(2, '0')}:${timerController.waktu.value.minute.toString().padLeft(2, '0')}:${timerController.waktu.value.second.toString().padLeft(2, '0')}",
                    style: TextStyle(fontSize: 45),
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Clock(
                circleColor: Colors.black,
                bellColor: Colors.green,
                clockText: ClockText.arabic,
                isAlarm: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
