
import 'package:flutter/material.dart';

class EkChooseCarProblemButton extends StatelessWidget{
  const EkChooseCarProblemButton(
      {super.key,
        required this.title,
        this.onTap,
        this.backgroundColor,
        this.titleColor,
        this.showLoading,
        this.width,
        this.height,
        this.elevation,
        this.label,
        this.borderRadius = 8});

  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? titleColor;
  final String? title;
  final String? label;
  final bool? showLoading;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12) ,
      child: SizedBox(
        height: height ?? 50,
        width: width ?? MediaQuery.of(context).size.width,
        child: InputDecorator(
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(),
            labelText:  "$label *",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FittedBox(
              child: Text(
                title ?? '',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
