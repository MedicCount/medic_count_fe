import 'package:flutter/material.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';
import 'package:medic_count_fe/pages/home.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      _fetchData(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Loading Page',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void navigateToLoadingPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingPage()),
    );
  }

  void _fetchData(BuildContext context) async {
    await AllDatas().fetchAllData();
    await Future.delayed(const Duration(seconds: 2));

    bool apiSuccess = true;

    if (apiSuccess) {
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }
}
