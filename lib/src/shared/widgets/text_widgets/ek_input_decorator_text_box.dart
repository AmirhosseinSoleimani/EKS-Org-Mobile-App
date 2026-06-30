import 'package:flutter/material.dart';

class EkInputDecoratorTextBox extends StatelessWidget {
  final String? label;
  final String? text;

  const EkInputDecoratorTextBox({this.label, this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label ?? '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
        labelStyle: Theme.of(context).textTheme.titleMedium,
      ),
      child: Text(text ?? ''),
    );
  }
}
