import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
class RescuerFormSection extends StatelessWidget {
  final String title; final IconData icon; final Widget child;
  const RescuerFormSection({super.key, required this.title, required this.icon, required this.child});
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppPadding.p16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppSize.s16), boxShadow:[BoxShadow(color: Colors.black.withAlpha(18),blurRadius:8,offset:const Offset(0,3))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children:[Row(children:[Icon(icon,color:Theme.of(context).colorScheme.primary),const SizedBox(width:8),BodyMediumText(text:title,fontWeight:FontWeight.w700,fontSize:17)]),const Divider(height:28),child]),
  );
}
