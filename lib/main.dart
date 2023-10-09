import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remoteconfig/remote_config.dart';
import 'app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseRemoteConfigService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfigService();
    // String theme='theme_mode';
    return MaterialApp(
      theme: ThemeData.light(), // Default light theme
      darkTheme: ThemeData.dark(), // Default dark theme
      themeMode:
          remoteConfig.themeCode == 'dark' ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfigService();

    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text(
            remoteConfig.themeCode,
            textAlign: TextAlign.center,

          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => ScreenPage()));
          },
        ),
      ),
    );
  }
}
