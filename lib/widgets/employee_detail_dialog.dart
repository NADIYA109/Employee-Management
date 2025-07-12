import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeeDetailDialog extends StatelessWidget {
  final Employee employee;
  const EmployeeDetailDialog({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(employee.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Position: ${employee.position}'),
          Text('Department: ${employee.department}'),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }
}
