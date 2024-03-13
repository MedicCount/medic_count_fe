import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medic_count_fe/pages/loginPage.dart';

Future<void> signOut(context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}