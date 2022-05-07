import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'button_widget.dart';

class ProfileWidget extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(children: [
        buildImage(),
        Positioned(bottom: 0, right: 4, child: buildEditIcon(color))
      ]),
    );
  }

  Widget buildImage() {
    final image = imagePath == null ? null : NetworkImage(imagePath!);

    if (image == null) {
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(64)),
            ),
          ),
        ),
      );
    }
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  // ignore: prefer_const_constructors
  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

// import 'package:einstein/data/constants.dart';
// import 'package:flutter/material.dart';

// class ProfileWidget extends StatelessWidget {
//   static const _testIconLink =
//       'https://previews.123rf.com/images/vgstudio/vgstudio1308/vgstudio130800053/21269255-portrait-der-sch%C3%B6nen-jungen-gl%C3%BCcklich-l%C3%A4chelnde-frau-im-freien.jpg';
//   const ProfileWidget({Key? key}) : super(key: key);

//   @override
// @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Theme.of(context).colorScheme.secondary,
//             width: 2,
//           ),
//         ),
//         child: Row(children: [
//           IconButton(
//             icon: Image.network(_testIconLink),
//             iconSize: Constants.profilePictureSize,
//             onPressed: () {},
//           ),
//           Spacer(flex: 10),
//           Column(
//             children: [
//               const Text('Name'),
//               //const Spacer(flex: 1),
//               TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.all(16.0),
//                     primary: Colors.white,
//                     textStyle: const TextStyle(fontSize: 14),
//                   ),
//                   onPressed: () {},
//                   child: const Text("follow"))
//             ],
//           ),
//           Spacer(flex: 2),
//         ]));
//   }
// }
