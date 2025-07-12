import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/employee_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmployeeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
