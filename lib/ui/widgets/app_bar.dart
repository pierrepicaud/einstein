import 'package:einstein/ui/screens/s_settings.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {

  return AppBar(
    leading: BackButton(
      color: Theme.of(context).dividerColor,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).dividerColor,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const SettingsScreen()));
        },
      ),
    ],
  );
}
