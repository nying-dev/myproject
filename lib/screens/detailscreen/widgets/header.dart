import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:myproject/models/model.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  final MGrocery item;
  const Header({
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: ClipPath(
        clipper: MyClipper(),
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 15, top: 20, bottom: 20),
          decoration: BoxDecoration(
            color: kSecondaryColor,
          ),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.chevron_left,
                            color: kBlackColor, size: 30),
                      ),
                    ],
                  ),
                  Hero(
                    tag: item.hashCode,
                    child: Image.network(
                      item.url,
                      scale: 4,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
