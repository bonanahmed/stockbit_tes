import 'package:stockbit_tes/Clock Widget/clock_text.dart';
import 'package:flutter/material.dart';
import 'package:stockbit_tes/Clock Widget/clock_face.dart';

class Clock extends StatelessWidget {
  final Color circleColor;
  final Color bellColor;
  final Color legColor;
  final ClockText clockText;
  final bool isAlarm;

  const Clock({
    Key? key,
    this.circleColor = Colors.black,
    this.bellColor = const Color(0xFF333333),
    this.legColor = const Color(0xFF555555),
    this.clockText = ClockText.arabic,
    this.isAlarm = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: buildClockCircle(context),
    );
  }

  Container buildClockCircle(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 5.0),
            blurRadius: 5.0,
          )
        ],
      ),
      child: ClockFace(
        clockText: clockText,
        isAlarm: isAlarm,
      ),
    );
  }
}
