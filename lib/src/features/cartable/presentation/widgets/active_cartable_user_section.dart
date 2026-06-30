import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/active_cartable_user_info.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/cartable_change_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:flutter/material.dart';

import 'user_avatar.dart';

class ActiveCartableUserSection extends StatelessWidget {
  final SubordinatedUserEntity? activeUser;
  final VoidCallback? onChangeCartableTap;

  const ActiveCartableUserSection({
    super.key,
    required this.activeUser,
    this.onChangeCartableTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FormSectionContainer(
      child: Row(
        children: [
          UserAvatar(
            avatarUrl:'',
          ),

          const SizedBox(width: 12),

          Expanded(
            child: ActiveCartableUserInfo(
              name: activeUser?.name,
              roleTitle: activeUser?.name,
            ),
          ),

          const SizedBox(width: 8),

          CartableChangeButton(
            title: 'تغییر کارتابل',
            borderColor: const Color(0xFF717171),
            textColor: const Color(0xFF717171),
            onTap: onChangeCartableTap,
          ),
        ],
      ),
    );
  }
}

