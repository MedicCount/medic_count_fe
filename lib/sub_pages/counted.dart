import 'package:flutter/material.dart';

class CountedPage extends StatefulWidget {
  const CountedPage({super.key});

  @override
  State<CountedPage> createState() => _CountedPageState();
}

class _CountedPageState extends State<CountedPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Counted Page'),
    );
  }
}