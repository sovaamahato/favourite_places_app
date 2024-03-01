import 'package:favourite_places_app/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/colors.dart';
import 'developer_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: background,
      child: Column(children: [
        //logo
        DrawerHeader(
          child: Center(
            child: Icon(
              FontAwesomeIcons.solidAddressBook,
              size: 40,
              color: DeepPurple,
            ),
          ),
        ),

        //home tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 25),
          child: ListTile(
            title: Text(
              "H O M E",
              style: TextStyle(color: DeepPurple),
            ),
            leading: Icon(
              Icons.home,
              color: DeepPurple,
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
        //add new place
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 25),
          child: ListTile(
            title: Text(
              "A D D  N E W  P L A C E",
              style: TextStyle(color: DeepPurple),
            ),
            leading: Icon(
              Icons.add_a_photo,
              color: DeepPurple,
            ),
            onTap: () {
              //pop drawer
              Navigator.pop(context);
              //navigate to settings page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AddPlaceScreen()));
            },
          ),
        ),
        //about me
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 25),
          child: ListTile(
            title: Text(
              "A B O U T  M E",
              style: TextStyle(color: DeepPurple),
            ),
            leading: Icon(
              Icons.person,
              color: DeepPurple,
            ),
            onTap: () {
              //pop drawer
              Navigator.pop(context);
              //navigate to settings page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => DeveloperScreen()));
            },
          ),
        ),
      ]),
    );
  }
}
