import 'package:flutter/material.dart';

class BaseDropdown extends StatefulWidget {
  const BaseDropdown({Key? key, required this.list}) : super(key: key);

  final List<String> list;

  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first; // Initialize dropdownValue with the first item from the list
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          if (value != null) {
            setState(() {
              dropdownValue = value;
            });
          }
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
              style: TextStyle(
                fontSize: 12,
              )
            ),
          );
        }).toList(),
      ),
    );
  }
}
