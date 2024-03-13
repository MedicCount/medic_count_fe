import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medic_count_fe/firebase_options.dart';
import 'package:medic_count_fe/pages/notFoundPage.dart';
import 'package:medic_count_fe/pages/homePage.dart';
import 'package:medic_count_fe/pages/prePage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Stream<User?> _authStateStream;

  @override
  void initState() {
    super.initState();
    _authStateStream = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medic Count',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthCheck(authStateStream: _authStateStream),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return _checkAuthAndRoute(const HomePage());
          case '/pre':
            return MaterialPageRoute(builder: (_) => const PrePage());
          default:
            return MaterialPageRoute(builder: (_) => const NotFoundPage());
        }
      },
    );
  }

  MaterialPageRoute _checkAuthAndRoute(Widget page) {
    return MaterialPageRoute(builder: (_) {
      return StreamBuilder<User?>(
        stream: _authStateStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasData) {
              return page;
            } else {
              return const PrePage();
            }
          }
        },
      );
    });
  }
}

class AuthCheck extends StatelessWidget {
  final Stream<User?> authStateStream;

  const AuthCheck({Key? key, required this.authStateStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authStateStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const PrePage();
          }
        }
      },
    );
  }
}
