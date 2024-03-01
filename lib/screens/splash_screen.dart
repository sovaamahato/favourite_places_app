import 'package:favourite_places_app/components/colors.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'places.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const PlacesScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 143, 126, 210),
      body: Container(
        decoration: const BoxDecoration(),
        child: Center(
            child: Column(
          children: [
            const Spacer(flex: 1),
            LottieBuilder.asset("assets/animation4.json"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Version 1.0.1",
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            //lottie loading
            //const CustomLoading(),
            const Text(
              'Copyright:@Sovaa',
              style:
                  TextStyle(color: Colors.white, fontFamily: 'sans_semibold'),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        )),
      ),
    );
  }
}
