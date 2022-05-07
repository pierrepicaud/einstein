import 'package:einstein/ui/account/profile_page.dart';
import 'package:einstein/ui/widgets/profile_settings_tile.dart';
import 'package:einstein/ui/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = "/home/profile";

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfilePage(),
    );
  }
}
