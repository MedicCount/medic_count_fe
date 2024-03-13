import 'package:flutter/material.dart';

class BaseModal extends StatelessWidget {

  final String header;
  final String body;
  final List<Widget> buttons;

  const BaseModal({
    super.key,
    required this.header,
    required this.body,
    required this.buttons
  });

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(header),
          content: Text(body,),
          actions: buttons,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
