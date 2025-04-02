import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AuthScreenLogo extends StatelessWidget {
  const AuthScreenLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 115,
        height: 115,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: HugeIcon(
            icon: HugeIcons.strokeRoundedUserLock01,
            color: Colors.white,
            size: 60),
      ),
    );
  }
}
