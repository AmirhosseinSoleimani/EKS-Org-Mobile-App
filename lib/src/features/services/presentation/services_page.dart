

import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  static const path = "/services";
  static const name = "services";

  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("خدمات", style: TextStyle(color: Colors.black),)),
    );
  }
}
