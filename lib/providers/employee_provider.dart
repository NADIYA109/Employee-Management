import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [];
  List<Employee> get employees => _employees;

  final String apiUrl = 'https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee';

  Future<void> fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        _employees = data.map((e) => Employee.fromJson(e)).toList();
        notifyListeners();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetch error: $e');
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(employee.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _employees.add(employee);
        notifyListeners();
      } else {
        print('Add error: ${response.statusCode}');
      }
    } catch (e) {
      print('Add exception: $e');
    }
  }

 
  List<Employee> search(String query) {
    return _employees
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
