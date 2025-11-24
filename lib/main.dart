import 'package:flutter/material.dart';
import 'package:tribus/screens/register_recyclable_material.screen.dart';
import 'package:tribus/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tribus',
      theme: AppTheme.lightTheme,
      home: const RegisterRecyclableMaterialScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
