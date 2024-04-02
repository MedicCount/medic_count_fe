import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medic_count_fe/components/base_collapse.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late String email;
  late String? photoUrl;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email!;
    photoUrl = FirebaseAuth.instance.currentUser!.photoURL;
    if (photoUrl == null) {
      photoUrl = 'https://static-00.iconduck.com/assets.00/profile-default-icon-256x256-tsi8241r.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 200,
          child: Container(
            child: Center(
              child: Row(
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
                    width: 200,
                    margin: EdgeInsets.only(left: 20),
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(email,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(email),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text('Edit',
                                            style:
                                                TextStyle(color: Colors.white))),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  BaseCollapse(
                    name: 'Appearance',
                  ),
                  BaseCollapse(
                    name: 'Languages',
                  ),
                  BaseCollapse(
                    name: 'Subscriptions',
                  ),
                  BaseCollapse(
                    name: 'Themes',
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
