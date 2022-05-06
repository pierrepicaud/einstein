import 'package:einstein/ui/account/profile_page.dart';
import 'package:einstein/ui/widgets/profile_settings_tile.dart';
import 'package:einstein/ui/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  static const routeName = "/home/profile";

  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePage(
          // onClicked: () {}, imagePath: '',
          ),
    );
  }
}
