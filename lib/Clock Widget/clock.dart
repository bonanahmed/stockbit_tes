import 'package:stockbit_tes/Clock Widget/clock_text.dart';
import 'package:flutter/material.dart';
import 'package:stockbit_tes/Clock Widget/clock_face.dart';

///This is clock widget that have 4 component which clock face at the base, clock text for the digits, clock dial painter for
///put the digits arounds the clock face, and clock hand for time indicator
class Clock extends StatelessWidget {
  final Color circleColor;
  final ClockText clockText;
  final bool isAlarm;

  const Clock({
    Key? key,
    this.circleColor = Colors.black,
    this.clockText = ClockText.arabic,
    this.isAlarm = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using aspect ratio so the clock can be round
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
      // This is the base of the clock which will contain clock hand
      child: ClockFace(
        clockText: clockText,
        isAlarm: isAlarm,
      ),
    );
  }
}
