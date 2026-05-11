import 'package:flutter/material.dart';
import 'package:newsapp/core/widgets/custom_appbar_widget.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),

      body: Column(
        children: [
          CustomAppbarWidget(title: 'Bookmark'),
          Center(child: Text('Bookmark Screen')),
        ],
      ),
    );
  }
}
