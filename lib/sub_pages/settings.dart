import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late String email;
  late String? photoUrl;
  bool darkTheme = false;
  String selectedLanguage = 'English';
  String selectedFontSize = 'Medium';

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email!;
    photoUrl = FirebaseAuth.instance.currentUser!.photoURL;
    photoUrl ??= 'https://static-00.iconduck.com/assets.00/profile-default-icon-256x256-tsi8241r.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 5.5,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100),
                            image: photoUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(photoUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                email,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                email,
                                style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Theme',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Dark Theme',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              Switch(
                                value: darkTheme,
                                onChanged: (value) {
                                  setState(() {
                                    darkTheme = value;
                                  });
                                },
                              ),
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Languages',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Language',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              DropdownButton<String>(
                                value: selectedLanguage,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedLanguage = newValue!;
                                  });
                                },
                                items: <String>[
                                  'English',
                                  'Spanish',
                                  'French',
                                  'German'
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ]),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Appearance',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Font size',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              DropdownButton<String>(
                                value: selectedFontSize,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedFontSize = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Small',
                                  'Medium',
                                  'Large'
                                ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
