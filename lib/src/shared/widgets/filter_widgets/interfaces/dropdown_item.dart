import 'package:flutter/material.dart';

abstract interface class DropdownItem {
  String get label;

  Widget? leading(BuildContext context) => null;
}