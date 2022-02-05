import 'dart:async';

import 'package:get/get.dart';
import 'package:stockbit_tes/models/time.dart';

class TimerController extends GetxController {
  DateTime _dateTime = DateTime.now();
  Timer? _timer;
  final _updateDuration = Duration(seconds: 1);

  var waktu = Time(hour: 0, minute: 0, second: 0, abbreviations: "AM").obs;

  void initTimer() {
    _timer = Timer.periodic(_updateDuration, setTime);
  }

  void disposeTimer() {
    _timer!.cancel();
  }

  void setTime(Timer timer) {
    _dateTime = DateTime.now();
    waktu.update((_) {
      waktu.value.hour = _dateTime.hour;
      waktu.value.minute = _dateTime.minute;
      waktu.value.second = _dateTime.second;
    });
  }
}
