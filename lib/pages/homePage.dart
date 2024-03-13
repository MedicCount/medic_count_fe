import 'package:flutter/material.dart';
import 'package:medic_count_fe/components/baseSignOut.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Home Page'),
            IconButton(onPressed: () {
              signOut(context);
            }, icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}