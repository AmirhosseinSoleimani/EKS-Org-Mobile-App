import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RescuerFullScreenSheetAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool resultOnClose;

  const RescuerFullScreenSheetAppBar({
    super.key,
    required this.title,
    this.resultOnClose = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(63);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          children: [
            BodyMediumText(
              text: title,
              color: const Color(0xFF6F6F6F),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            const Spacer(),
            InkWell(
              onTap: () => Navigator.of(context).pop(resultOnClose),
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close, color: Color(0xFF6F6F6F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
