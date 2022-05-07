import 'package:einstein/data/authentication/modules/account.dart';
import 'package:einstein/logic/authentication/h_user.dart';
import 'package:einstein/ui/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/numbers_widget.dart';

class ProfilePage extends StatefulWidget {
  final String? userID;
  const ProfilePage({
    Key? key,
    this.userID,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            physics: BouncingScrollPhysics(),
            children: [
              if(user == null)
                ProfileWidget(
                    // TODO: make witget work with null
                    imagePath: null,
                    onClicked: () async {},
                  )
              else
              FutureBuilder<String>(
                future: userHandler.getAvatarUrl(user.accPicId),
                builder: (context, snap) {
                  return ProfileWidget(
                    // TODO: make witget work with null
                    imagePath: snap.data,
                    onClicked: () async {},
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              // TODO: make it work with null
              buildName(user?.userName, "@emimi.fukada.94"),
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
              // TODO: make this work with null
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
              // ignore: prefer_const_constructors
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
              // ignore: prefer_const_constructors
              style: TextStyle(color: Colors.grey),
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
