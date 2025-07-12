import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/add_employee_sheet.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<EmployeeProvider>(context, listen: false).fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);
    final filteredList = provider.search(searchQuery);

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the application?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Employee List', showBackButton: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search employees...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (val) => setState(() => searchQuery = val),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredList.isEmpty
                    ? const Center(child: Text('No employees found'))
                    : ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (_, i) {
                          final emp = filteredList[i];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  emp.name.isNotEmpty ? emp.name[0].toUpperCase() : '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(emp.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(emp.position.isNotEmpty ? emp.position : 'No Position'),
                                  Text(emp.department.isNotEmpty ? emp.department : 'No Department'),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(emp.name),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Position: ${emp.position.isNotEmpty ? emp.position : 'Not Provided'}'),
                                        Text('Department: ${emp.department.isNotEmpty ? emp.department : 'Not Provided'}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (_) => const AddEmployeeSheet(),
            );
          },
          icon: const Icon(Icons.person_add, color: Colors.white),
          label: const Text(
            'Add Employee',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
