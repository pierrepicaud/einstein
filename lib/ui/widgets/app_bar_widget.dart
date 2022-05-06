import 'package:flutter/material.dart';

import '../settings_page.dart';

AppBar buildAppBar(BuildContext context) {
  // final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: const BackButton(
      color: Colors.black,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: const Icon(
          Icons.settings,
          color: Colors.green,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => SettingsPage()));
        },
      ),
    ],
  );
}
