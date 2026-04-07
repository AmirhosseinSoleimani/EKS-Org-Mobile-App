import 'package:flutter/cupertino.dart';

class ServiceListViewer extends StatelessWidget {
  final List<dynamic> items;

  const ServiceListViewer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return const Text("Items");
  }
}
