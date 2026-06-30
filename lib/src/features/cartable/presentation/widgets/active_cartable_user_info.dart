import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class ActiveCartableUserInfo extends StatelessWidget {
  final String? name;
  final String? roleTitle;

  const ActiveCartableUserInfo({super.key, this.name, this.roleTitle});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyMediumText(
          text: 'کارتابل فعال: ${name?.trim().isNotEmpty == true ? name : '-'}',
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        ),

        const SizedBox(height: 4),

        BodyMediumText(
          text:
              'نقش: ${roleTitle?.trim().isNotEmpty == true ? roleTitle : '-'}',
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
