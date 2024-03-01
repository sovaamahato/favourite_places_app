import 'package:favourite_places_app/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background2,
        title: Text(
          "About Me ",
          style: TextStyle(color: DeepPurple),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //imge
              SizedBox(
                height: 250,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: LottieBuilder.asset("assets/me1.json"),
                  // ClipOval(
                  //   clipBehavior: Clip.antiAlias,
                  //   child: Image.asset(
                  //     "assets/me.png",
                  //     fit: BoxFit.cover,
                  //     //isAntiAlias: true,
                  //     height: 300,
                  //     width: 300,
                  //     // width: 400,
                  //   ),
                  // ),
                ),
              ),

              //details haru
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sova Kushwaha",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 117, 63, 210)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Acomplished Mobile App developer who is able to cretae mobile applications for every mobile software system platform.",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Connect with me",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              final Uri url = Uri.parse(
                                  'https://www.facebook.com/sova.mahato.754');
                              launchUrl(url);
                            },
                            icon: const Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.github,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final Uri url = Uri.parse(
                                  'https://www.instagram.com/kushwaha_sovaa/');
                              launchUrl(url);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.linkedinIn,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      height: 15,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: background,
                      ),
                      child: Text(
                        "See my other Apps ",
                        style: TextStyle(
                            color: DeepPurple, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
