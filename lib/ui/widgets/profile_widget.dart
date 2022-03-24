import 'package:einstein/data/constants.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  static const _testIconLink =
      'https://previews.123rf.com/images/vgstudio/vgstudio1308/vgstudio130800053/21269255-portrait-der-sch%C3%B6nen-jungen-gl%C3%BCcklich-l%C3%A4chelnde-frau-im-freien.jpg';
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
      ),
      child: Center(
        child: IconButton(
          icon: Image.network(_testIconLink),
          iconSize: Constants.profilePictureSize,
          onPressed: () {},
        ),
      ),
    );
  }
}
