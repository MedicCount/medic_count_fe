import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medic_count_fe/components/baseButton.dart';
import 'package:medic_count_fe/components/baseModal.dart';
import 'package:medic_count_fe/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final BaseModal modal = BaseModal(
    header: 'Login Failed',
    body: 'Please check your email and password',
    buttons: [
      TextButton(
        child: const Text('OK'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );

  Future<String?> login_default(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<UserCredential?> login_google() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credetial = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credetial);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Login Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                      )
                    ],
                  ),
                  Text('Welcome back MediCine !'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text.rich(
                            TextSpan(
                              text: 'Medi',
                              style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color:
                                    Colors.black, // Set the default text color
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'C', // Make the letter 'c' blue
                                  style: TextStyle(
                                      color: Color.fromRGBO(128, 0, 255, 1)),
                                ),
                                TextSpan(
                                  text: 'ine', // Remaining text after 'c'
                                  style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Set the default text color
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                            ),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'E-mail shouldn\'t be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                              ),
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password shouldn\'t be empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          BaseButton(
                            goTo: () async {
                              if (_formKey.currentState!.validate()) {
                                var email = emailController.text;
                                var password = passwordController.text;
                                var uid = await login_default(email, password);
                                if (uid == null) {
                                  modal.dialogBuilder(context);
                                } else {
                                  print('Login successful');
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ));
                                }
                              }
                            },
                            label: 'Login',
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40, bottom: 40),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Or sign up with',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: SvgPicture.asset(
                                      'assets/images/googleIcon.svg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Login with Google'),
                                ],
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(
                                color: Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              var userCredential = await login_google();
                              if (userCredential != null) {
                                print(userCredential.toString());
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ));
                              }
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Not register yet ? '),
                                InkWell(
                                  onTap: () {},
                                  child: Text('Create Account',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
