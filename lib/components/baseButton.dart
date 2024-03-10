import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  
  final String label;
  final Function goTo;

  const BaseButton({
    super.key,
    required this.goTo,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(label,
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(128, 0, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => goTo(),
    );
  }
}
