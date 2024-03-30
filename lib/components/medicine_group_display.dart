import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medic_count_fe/classes/medicine.dart';

class MedicineGroupDisplay extends StatelessWidget {
  final String groupName;
  final DateTime timeCreated;
  final List<Medicine> medicineGroup;

  const MedicineGroupDisplay({
    super.key,
    required this.groupName,
    required this.timeCreated,
    required this.medicineGroup
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          groupName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Created",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm:ss').format(timeCreated),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: medicineGroup.map((medicine) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.circle,
                            size: 8,
                          ),
                        ),
                        Text(
                          medicine.getName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          NumberFormat('#,##0').format(medicine.getCount),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.image),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
