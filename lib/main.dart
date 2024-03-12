import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medic_count_fe/firebase_options.dart';
import 'package:medic_count_fe/pages/loginPage.dart';
import 'package:medic_count_fe/pages/prePage.dart';
import 'pages/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    return MaterialApp(
      initialRoute: '/prePage',
      routes: {
        '/': (context) => const Home(),
        '/prePage': (context) => const PrePage(),
        '/loginPage': (context) => const LoginPage(),
      },
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
    );
  }
}
