import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/active_cartable_user_info.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/cartable_change_button.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:flutter/material.dart';

import 'user_avatar.dart';

class ActiveCartableUserSection extends StatelessWidget {
  final String? name;
  final String? roleTitle;
  final bool isLoading;
  final VoidCallback? onChangeCartableTap;

  const ActiveCartableUserSection({
    super.key,
    required this.name,
    required this.roleTitle,
    required this.isLoading,
    this.onChangeCartableTap,
  });

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      padding: const EdgeInsets.all(AppSize.s16),
      margin: const EdgeInsets.all(0),
      child: Row(
        children: [
          const UserAvatar(
            avatarUrl: '',
          ),

          const SizedBox(width: 12),

          Expanded(
            child: ActiveCartableUserInfo(
              name: name,
              roleTitle: roleTitle,
            ),
          ),

          const SizedBox(width: 8),

          CartableChangeButton(
            title: 'تغییر کارتابل',
            borderColor: const Color(0xFF717171),
            textColor: const Color(0xFF717171),
            isLoading: isLoading,
            onTap: onChangeCartableTap,
          ),
        ],
      ),
    );
  }
}