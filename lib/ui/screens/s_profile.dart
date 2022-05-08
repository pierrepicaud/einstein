import 'package:einstein/data/modules/account.dart';
import 'package:einstein/logic/h_user.dart';
import 'package:einstein/ui/widgets/app_bar.dart';
import 'package:einstein/ui/widgets/button.dart';
import 'package:einstein/ui/widgets/numbers.dart';
import 'package:einstein/ui/widgets/profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String? userID;
  const ProfileScreen({
    Key? key,
    this.userID,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userID;
  final userHandler = HUser();

  @override
  void initState() {
    userID = widget.userID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userFuture =
        (userID == null) ? userHandler.cUser : userHandler.getUserByID(userID!);

    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder<Account>(
        future: userFuture,
        builder: (context, snapshot) {
          final user = snapshot.data;
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              if (user == null)
                ProfileWidget(
                  imagePath: null,
                  onClicked: () async {},
                )
              else
                FutureBuilder<String>(
                  future: userHandler.getAvatarUrl(user.accPicId),
                  builder: (context, snap) {
                    return ProfileWidget(
                      imagePath: snap.data,
                      onClicked: () async {},
                    );
                  },
                ),
              const SizedBox(
                height: 24,
              ),
              buildName(user?.userName, "@emimi.fukada.94"),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: buildUpgradeButton(),
              ),
              const SizedBox(
                height: 24,
              ),
              const NumbersWidget(),
              const SizedBox(
                height: 80,
              ),
              if (user?.about != null) buildAbout(user!.about!),
            ],
          );
        },
      ),
    );
  }

  Widget buildName(String? name, String? email) => Column(
        children: [
          if (name == null)
            SizedBox(
              height: 24,
              child: Container(
                color: Colors.grey,
              ),
            )
          else
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          const SizedBox(height: 4),
          if (email == null)
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.grey,
              ),
            )
          else
            Text(
              email,
              style: const TextStyle(color: Colors.grey),
            )
        ],
      );
  // TODO: increase follow count
  Widget buildUpgradeButton() => (ButtonWidget(
        text: "Follow",
        onClicked: () {},
      ));
  Widget buildAbout(String about) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            )
          ],
        ),
      );
}
