import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medic_count_fe/firebase_options.dart';
import 'package:medic_count_fe/pages/homePage.dart';
import 'package:medic_count_fe/pages/loginPage.dart';
import 'package:medic_count_fe/pages/prePage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medic_count_fe/pages/settingPage.dart';
import 'package:medic_count_fe/pages/statPage.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => const HomePage(),
      '/prePage': (context) => PrePage(),
      '/loginPage': (context) => LoginPage(),
      '/statPage': (context) => const StatPage(),
      '/settingPage': (context) => const SettingPage(),
    };

    return MaterialApp(
      title: 'Medic Count',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/prePage',
      routes: routes,
    );
  }

}
