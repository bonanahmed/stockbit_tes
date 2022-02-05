import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stockbit_tes/notification_api.dart';
import 'package:stockbit_tes/view/app_clock_page.dart';
import 'package:stockbit_tes/view/bar_chart_page.dart';
import 'package:stockbit_tes/view/set_alarm_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetStorage getStorage = GetStorage();
  int _currentIndex = 0;
  List _listPage = [AppClock(), SetAlarmPage()];
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotification();
  }

  void listenNotification() =>
      NotificationApi.onNotification.stream.listen(onClickNotification);

  void onClickNotification(String? payload) {
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
