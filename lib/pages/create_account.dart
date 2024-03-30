import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medic_count_fe/components/base_button.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;
  bool _emailExistsError = false;
  bool _termsError = false;

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _confirmPasswordController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account was Created!'),
          duration: Duration(seconds: 5),
        )
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setState(() {
          _emailExistsError = true;
        });
      } else {
        print('Error occurred: ${e.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> checkEmailExistence() async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text.trim());
      if (methods.isNotEmpty) {
        setState(() {
          _emailExistsError = true;
        });
      } else {
        setState(() {
          _emailExistsError = false;
        });
        signUp();
      }
    } catch (e) {
      print('Error occurred while checking email existence: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      final RegExp emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (newValue) {
                          setState(() {
                            _agreedToTerms = newValue!;
                            _termsError = false;
                          });
                        },
                      ),
                      const Text(
                        'I agree to the terms and conditions',
                      ),
                    ],
                  ),
                  if (_emailExistsError)
                    Text(
                      'Email already exists',
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  if (_termsError)
                    Text(
                      'Please agree to the terms and conditions',
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  const SizedBox(height: 30),
                  BaseButton(
                    label: "Create",
                    function: () {
                      setState(() {
                        _emailExistsError = false;
                        _termsError = !_agreedToTerms;
                      });
                      if (_formKey.currentState!.validate() &&
                          _agreedToTerms) {
                        checkEmailExistence();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
