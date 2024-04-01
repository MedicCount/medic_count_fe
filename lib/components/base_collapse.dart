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
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          title: Text(widget.name), // accessing name from widget
          subtitle: Text('Leading expansion arrow icon'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('This is tile number 3')),
          ],
        ),
      ),
    );
  }
}
