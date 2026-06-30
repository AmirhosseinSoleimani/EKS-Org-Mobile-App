import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUrl;

  const UserAvatar({
    super.key,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    final hasAvatar = avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    return CircleAvatar(
      radius: 22,
      backgroundColor: hasAvatar
          ? Colors.transparent
          : errorColor.withAlpha(90),
      backgroundImage: hasAvatar ? NetworkImage(avatarUrl!) : null,
      child: hasAvatar
          ? null
          : Icon(
        Icons.person,
        color: errorColor,
        size: 24,
      ),
    );
  }
}