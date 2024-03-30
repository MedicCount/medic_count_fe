import 'package:flutter/material.dart';
import 'package:medic_count_fe/components/base_sign_out.dart';
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
  List<String> headerLabel = ['Counted Medicines', 'Create New Group', 'Statistics', 'Settings'];
  List<String> bottomNavLabel = ['Home', 'Groups', 'Statistics', 'Settings'];
  int indexBottomNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: () {
          if (headerLabel[indexBottomNav] == 'Settings') {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headerLabel[indexBottomNav],
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    signOut(context);
                  },
                  icon: const Icon(Icons.logout)),
              ],
            );
          } else {
            return Text(
              headerLabel[indexBottomNav],
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            );
          }
        }(),
        automaticallyImplyLeading: false,
      ),
      body: widgetOption[indexBottomNav],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() => indexBottomNav = value);
        },
        currentIndex: indexBottomNav,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: bottomNavLabel[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.medical_services),
            label: bottomNavLabel[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            label: bottomNavLabel[2],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: bottomNavLabel[3],
          ),
        ],
      ),
    );
  }
}
