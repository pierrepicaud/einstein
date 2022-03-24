import 'package:einstein/ui/widgets/profile_settings_tile.dart';
import 'package:einstein/ui/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const ProfileWidget(),
          SettingTile(
            icon: Icons.person,
            child: const Text("profile details"),
            onTap: () {},
          ),
          SettingTile(
            icon: Icons.settings,
            child: const Text("settings"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}