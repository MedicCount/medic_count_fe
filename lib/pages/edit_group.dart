import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_count_fe/classes/medicine.dart';
import 'package:medic_count_fe/classes/medicine_group.dart';
import 'package:medic_count_fe/components/buttons.dart';
import 'package:medic_count_fe/datasources/all_datasources.dart';
import 'package:medic_count_fe/pages/camera.dart';
import 'package:medic_count_fe/pages/loading.dart';

class EditGroupsPage extends StatefulWidget {
  final MedicineGroup medicineGroups;
  final Function() reloadPage;

  const EditGroupsPage(
      {Key? key, required this.medicineGroups, required this.reloadPage})
      : super(key: key);

  @override
  State<EditGroupsPage> createState() => _EditGroupsPageState();
}

class _EditGroupsPageState extends State<EditGroupsPage> {
  final List<String> sortOptions = ['Name', 'Date Created'];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void saveToDatabase() {
    widget.reloadPage();
  }

  void reloadPage() {
    setState(() {});
  }

  List<Medicine> showAllMedicine() {
    List<Medicine> medicines = [];
    for (Medicine temp in widget.medicineGroups.getMedicineGroup) {
      medicines.add(temp);
    }
    for (Medicine temp in AllDatas().temporaryMedicineFromEditGroup) {
      medicines.add(temp);
    }
    return medicines;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Group',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: TextEditingController(
                        text: widget.medicineGroups.getName),
                    decoration: const InputDecoration(
                      labelText: 'Enter Group Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => {
                      widget.medicineGroups.setName = value
                    },
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Camera(
                          medicines:
                              AllDatas().temporaryMedicineFromEditGroup,
                          mgid: widget.medicineGroups.getMgid,
                          reloadPage: reloadPage,
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
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1.5),
                          2: FlexColumnWidth(0.5),
                          3: FlexColumnWidth(0.5),
                          4: FlexColumnWidth(0.5),
                          5: FlexColumnWidth(0.1),
                        },
                        children: <TableRow>[
                          if (widget.medicineGroups.getMedicineGroup.isNotEmpty)
                            for (final Medicine medicine
                                in showAllMedicine())
                              TableRow(
                                children: <Widget>[
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                      style: const ButtonStyle(
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
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
                                      style: const ButtonStyle(
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
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
                                      style: const ButtonStyle(
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      icon: const Icon(
                                          Icons.remove_circle_outline_outlined),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: BaseButton(
                          function: () async {
                            await AllDatas().detectAllTemporaryEditGroup(
                              widget.medicineGroups.getMgid, widget.medicineGroups.getName);
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            if (!context.mounted) return;
                            LoadingPage.navigateToLoadingPage(context);
                          },
                          label: 'Save and Detect',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SecondaryButton(
                          function: () async {
                            for (Medicine medicine in AllDatas().temporaryMedicineFromEditGroup) {
                              await medicine.deleteMedicine();
                            }
                            AllDatas().temporaryMedicineFromEditGroup.clear();
                            Navigator.of(context).pop();
                          },
                          label: 'Cancel',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
                  function: () async {
                    await medicine.modifyMedicine(
                      nameController.text,
                      int.tryParse(countController.text) ?? 0
                    );
                    reloadPage();
                    if (!context.mounted) return;
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
                    setState(() {
                      widget.medicineGroups.removeMedicine(medicine);
                    });
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
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
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
