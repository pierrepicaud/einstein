import 'package:einstein/ui/screens/s_profile.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = "/home/profile";

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileScreen(),
    );
  }
}
