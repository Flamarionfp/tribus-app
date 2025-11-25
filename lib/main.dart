import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tribus/screens/splash.screen.dart';
import 'package:tribus/screens/register_recyclable_material.screen.dart';
import 'package:tribus/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppInitializer());
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await dotenv.load();
    await Future.delayed(const Duration(milliseconds: 400));

    setState(() => loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      );
    }

    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tribus',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const RegisterRecyclableMaterialScreen(),
    );
  }
}
