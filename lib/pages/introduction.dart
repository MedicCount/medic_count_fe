import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medic_count_fe/components/base_button.dart';
import 'package:medic_count_fe/pages/login.dart';

class PrePage extends StatelessWidget {

  const PrePage({
    super.key,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              child: SizedBox(
                height: 500,
                child: SvgPicture.asset(
                  'assets/images/prePageTemplate.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 450,
                  ),
                  const Text(
                    'Explore the app',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 140,
                    child: Expanded(
                      child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi maecenas quis interdum enim enim molestie faucibus. Pretium non non massa eros, nunc, urna. Ac laoreet sagittis donec vel. Amet, duis justo, quam quisque egestas. Quam enim at dictum condimentum. Suspendisse.',
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          )),
                    ),
                  ),
                  BaseButton(
                      label: "Let's Start",
                      function: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
