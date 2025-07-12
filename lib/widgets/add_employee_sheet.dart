import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/employee.dart';
import '../providers/employee_provider.dart';

class AddEmployeeSheet extends StatefulWidget {
  const AddEmployeeSheet({super.key});

  @override
  State<AddEmployeeSheet> createState() => _AddEmployeeSheetState();
}

class _AddEmployeeSheetState extends State<AddEmployeeSheet> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();

  void submit() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        name: nameController.text.trim(),
        position: positionController.text.trim(),
        department: departmentController.text.trim(),
        id: '',
      );
      Provider.of<EmployeeProvider>(context, listen: false)
          .addEmployee(employee)
          .then((_) => Navigator.pop(context));
    }
  }

  InputDecoration buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Wrap(
            runSpacing: 16,
            children: [
              const Text(
                'Add New Employee',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: nameController,
                decoration: buildInputDecoration('Full Name', Icons.person),
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: positionController,
                decoration: buildInputDecoration('Job Position', Icons.work_outline),
                validator: (val) => val!.isEmpty ? 'Enter position' : null,
              ),
              TextFormField(
                controller: departmentController,
                decoration: buildInputDecoration('Department', Icons.apartment),
                validator: (val) => val!.isEmpty ? 'Enter department' : null,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Add Employee',
                  style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
