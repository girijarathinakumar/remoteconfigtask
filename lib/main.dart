// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'firebase_options.dart';
// import 'home_screen.dart';
//
// Future<void> main()async {
//     WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//   home: HomePage(),
//     );
//   }
// }
// class HomePage extends StatefulWidget {
//
//
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:remoteconfig/remote_config.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseRemoteConfigService().initialize();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {

   final remoteConfig = FirebaseRemoteConfigService();
    // String theme='theme_mode';
    return MaterialApp(
          theme: ThemeData.light(), // Default light theme
          darkTheme: ThemeData.dark(), // Default dark theme
          themeMode:remoteConfig == 'dark' ?ThemeMode.dark :ThemeMode.light,
          home: const HomeScreen(),
        );}}
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// String theme='';
//     void initState(){
//       fetchStringConfig();
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfigService();

    return Scaffold(
      body: Center(
        child: Text(
          remoteConfig.welcomeMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );


  }
// Future fetchStringConfig()async{
//
//   final remoteConfig = FirebaseRemoteConfig.instance;
//   await remoteConfig.setConfigSettings(RemoteConfigSettings(
//       fetchTimeout: const Duration(minutes: 1),
//       minimumFetchInterval: const Duration(minutes: 1 )));
//   await remoteConfig.fetchAndActivate();
//   theme = remoteConfig.getString("theme_mode");
//   setState(() {
//
//   });
// }

}
// Future<void> fetchRemoteConfig() async {
//   try {
//     FirebaseRemoteConfig remoteConfig = await FirebaseRemoteConfig.instance;
//     await remoteConfig.fetch();
//     await remoteConfig.activate();
//     final String welcomeMessage = remoteConfig.getString('theme_mode');
//     log('Welcome Message: $welcomeMessage');
//   } catch (e) {
//     print('Error fetching remote config: $e');
//   }
// }
