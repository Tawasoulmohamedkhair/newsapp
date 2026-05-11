import 'package:flutter/material.dart';

class CustomAppbarWidget extends StatelessWidget {
  const CustomAppbarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), centerTitle: true);
  }
}
