import 'package:flutter/material.dart';

abstract interface class DropdownItem<T>  {
  String get label;
  T get value;

  Widget? leading(BuildContext context) => null;

}