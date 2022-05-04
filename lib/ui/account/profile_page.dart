import 'dart:ui';

import 'package:einstein/data/authentication/modules/use_preferences.dart';
import 'package:einstein/ui/account/account.dart';
import 'package:einstein/ui/widgets/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/numbers_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPerferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            // The accPicID is an ID that will be converted into and url for image
            imagePath: user.accPicId.toString(),
            onClicked: () async {},
          ),
          const SizedBox(
            height: 24,
          ),
          buildName(user.userName, "fakeEmail@gg.com"),
          const SizedBox(
            height: 24,
          ),
          Center(
            // Change to follow button
            child: buildUpgradeButton(),
          ),
          const SizedBox(
            height: 24,
          ),
          NumbersWidget(),
          const SizedBox(
            height: 80,
          ),
          buildAbout(user.about.toString()),
        ],
      ),
    );
  }

  Widget buildName(String name, String email) => Column(
        children: [
          Text(
            name,
            // ignore: prefer_const_constructors
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            // ignore: prefer_const_constructors
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
  Widget buildUpgradeButton() => (ButtonWidget(
        text: "Upgrade To Pro",
        onClicked: () {},
      ));
  Widget buildAbout(String about) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_constructors
        children: [
          // ignore: prefer_const_constructors
          Text(
            "About",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            about,
            style: const TextStyle(fontSize: 16, height: 1.4),
          )
        ],
      ));
}
