import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockbit_tes/notification_api.dart';
import 'package:stockbit_tes/view/app_clock_page.dart';
import 'package:stockbit_tes/view/bar_chart_page.dart';
import 'package:stockbit_tes/view/set_alarm_page.dart';

///This is the homepage that contain bottom app bar, and
///which page we want to show
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  // This is the list consist of two pages
  // AppClock for see a clock,
  // SetAlarmPage for set alarm
  List _listPage = [AppClock(), SetAlarmPage()];
  @override
  void initState() {
    super.initState();
    // Init the notification setting
    NotificationApi.init();
    // For listening whether user tap the notification or not
    _listenNotification();
  }

  void _listenNotification() =>
      NotificationApi.onNotification.stream.listen(_onClickNotification);

  // If user tap on the notification, they will be redirected to bar chart page
  void _onClickNotification(String? payload) {
    Get.to(() => BarChartPage(payload: payload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.alarm,
            ),
            label: 'Clock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add_outlined),
            label: 'Alarm',
          ),
        ],
      ),
    );
  }
}
