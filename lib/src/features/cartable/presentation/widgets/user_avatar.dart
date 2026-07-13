import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUrl;

  const UserAvatar({
    super.key,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .colorScheme
        .primary;

    final hasAvatar = avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    return CircleAvatar(
      radius: 26,
      backgroundColor: hasAvatar
          ? Colors.transparent
          : primaryColor.withAlpha(30),
      backgroundImage: hasAvatar ? NetworkImage(avatarUrl!) : null,
      child: hasAvatar
          ? null
          : Icon(
        Icons.account_circle_outlined,
        color: primaryColor,
        size: 32,
      ),
    );
  }
}