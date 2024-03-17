import 'package:flutter/material.dart';
import 'package:medic_count_fe/sub_pages/counted.dart';
import 'package:medic_count_fe/sub_pages/groups.dart';
import 'package:medic_count_fe/sub_pages/settings.dart';
import 'package:medic_count_fe/sub_pages/statistics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgetOption = const <Widget>[
    CountedPage(),
    GroupsPage(),
    StatPage(),
    SettingPage(),
  ];
  int indexBottomNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOption[indexBottomNav],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() => indexBottomNav = value);
        },
        currentIndex: indexBottomNav,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
