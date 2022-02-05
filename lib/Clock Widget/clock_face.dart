import 'package:stockbit_tes/Clock Widget/clock_text.dart';
import 'package:flutter/material.dart';
import 'package:stockbit_tes/Clock Widget/clock_dial_painter.dart';
import 'package:stockbit_tes/Clock Widget/clock_hands.dart';

class ClockFace extends StatelessWidget {
  final ClockText clockText;
  final bool isAlarm;

  ClockFace({
    this.clockText = ClockText.arabic,
    this.isAlarm = false,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new AspectRatio(
        aspectRatio: 1.0,
        child: new Container(
          width: double.infinity / 2,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: new Stack(
            children: <Widget>[
              //Logo
              new Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/img/logo_stockbit.png"),
                  )),
              //dial and numbers
              new Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: new CustomPaint(
                  painter: new ClockDialPainter(clockText: clockText),
                ),
              ),

              //centerpoint
              new Center(
                child: new Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),

              new ClockHands(isAlarm: isAlarm),
            ],
          ),
        ),
      ),
    );
  }
}
