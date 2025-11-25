import 'package:flutter/material.dart';
import 'package:tribus/screens/register_recyclable_material.screen.dart';
import 'package:tribus/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
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
