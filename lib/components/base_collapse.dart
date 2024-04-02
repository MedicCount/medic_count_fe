import 'package:flutter/material.dart';

class BaseCollapse extends StatefulWidget {
  const BaseCollapse({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<BaseCollapse> createState() => _BaseCollapseState();
}

class _BaseCollapseState extends State<BaseCollapse> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide.none,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF4F4F4),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(widget.name),
            subtitle: const Text('Leading expansion arrow icon'),
            controlAffinity: ListTileControlAffinity.leading,
            children: const <Widget>[
              ListTile(title: Text('This is tile number 3')),
            ],
          ),
        ),
      ),
    );
  }
}
