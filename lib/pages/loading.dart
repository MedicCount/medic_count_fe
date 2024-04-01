import 'package:flutter/material.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';
import 'package:medic_count_fe/pages/home.dart';

class LoadingPage extends StatelessWidget {
  void _fetchData(BuildContext context) async {
    await AllDatas().fetchAllData();
    await Future.delayed(const Duration(seconds: 2));

    bool apiSuccess = true;

    if (apiSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchData(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Page'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}