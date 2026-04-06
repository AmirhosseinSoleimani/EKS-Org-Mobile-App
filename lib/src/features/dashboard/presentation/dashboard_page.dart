import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const path = "/dashboard";
  static const name = "dashboard";

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  Center(child: Text("داشبورد")),
    );
  }
}


