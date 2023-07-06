import 'package:curie_pay/utils/path.dart';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String? iconPath;
  const ProfileIcon({super.key, this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 60,
        width: null,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.network(iconPath ?? "${UriPath.profilePath}male"),
      ),
    );
  }
}
