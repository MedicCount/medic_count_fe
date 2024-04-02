import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/components/buttons.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';
import 'package:medic_count_fe/pages/camera.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Group Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Counted Medicines',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: BaseButton(
                function: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Camera(
                      reloadPage: reloadPage,
                      medicines: AllDatas().temporaryMedicinesFromCreateNewGrroup,
                      mgid: AllDatas().temporaryGroupId,
                    )));
                },
                label: 'Add New',
              ),
            ),
            const Divider(
              height: 50,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(0.5),
                3: FlexColumnWidth(0.5),
                4: FlexColumnWidth(0.5),
                5: FlexColumnWidth(0.1),
              },
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Medicine Names',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Total Count',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(width: 8),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(width: 8),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(width: 8),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              child: Scrollbar(
                thickness: 5,
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(0.5),
                      3: FlexColumnWidth(0.5),
                      4: FlexColumnWidth(0.5),
                      5: FlexColumnWidth(0.1),
                    },
                    children: <TableRow>[
                      if (AllDatas().temporaryMedicinesFromCreateNewGrroup.isNotEmpty)
                        for (final Medicine medicine in AllDatas().temporaryMedicinesFromCreateNewGrroup)
                          TableRow(
                            children: <Widget>[
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(
                                        Icons.circle,
                                        size: 8,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          medicine.getName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    NumberFormat('#,##0')
                                        .format(medicine.getCount),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: IconButton(
                                  icon: const Icon(Icons.image),
                                  onPressed: () {
                                    _showImageAlert(context, medicine);
                                  },
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditPopup(context, medicine);
                                  },
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline_outlined),
                                  onPressed: () {
                                    _showDeleteDialog(context, medicine);
                                  },
                                ),
                              ),
                              const TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              height: 50,
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: BaseButton(
                function: () {},
                label: 'Create New Group and Detect',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showEditPopup(BuildContext context, Medicine medicine) {
    TextEditingController nameController =
        TextEditingController(text: medicine.getName);
    TextEditingController countController =
        TextEditingController(text: medicine.getCount.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Medicine'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: nameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Count'),
                controller: countController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SecondaryButton(
                  function: () {
                    Navigator.of(context).pop();
                  },
                  label: 'Cancel',
                ),
                const SizedBox(width: 20),
                BaseButton(
                  function: () {
                    setState(() {
                      medicine.setName = nameController.text;
                      medicine.setCount = int.tryParse(countController.text) ?? 0;
                    });
                    Navigator.of(context).pop();
                  },
                  label: 'Save',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, Medicine medicine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Medicine'),
          content: Text('Are you sure you want to delete ${medicine.getName}?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SecondaryButton(
                  function: () {
                    Navigator.of(context).pop();
                  },
                  label: 'Cancel',
                ),
                const SizedBox(width: 20),
                BaseButton(
                  function: () async {
                    AllDatas().temporaryMedicineFromEditGroup.removeWhere((element) => element == medicine);
                    await medicine.deleteMedicine();
                    Navigator.of(context).pop();
                  },
                  label: 'Delete',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showImageAlert(BuildContext context, Medicine medicine) async {
    Uint8List? bytes = await medicine.fetchImage();
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Medicine Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: bytes != null
                ? Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }
}
