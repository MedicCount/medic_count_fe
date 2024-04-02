import 'package:flutter/material.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  void _fetchData(BuildContext context) async {
    await AllDatas().fetchAllData();
    await Future.delayed(const Duration(seconds: 2));

    bool apiSuccess = true;

    if (apiSuccess) {
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Page'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          _fetchData(context);
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
