import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final bool desableTrailing;
  final VoidCallback onTap;
  final String title;
  final IconData leeding;
  const ProfileTile({
    required this.desableTrailing,
    required this.onTap,
    required this.title,
    required this.leeding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: desableTrailing
          ? Container(
              width: 0,
              height: 0,
            )
          : const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
      leading: Icon(leeding),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
    );
  }
}