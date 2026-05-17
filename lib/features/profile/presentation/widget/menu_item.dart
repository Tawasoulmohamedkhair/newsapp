import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color, size: 26),
      title: Text(title, style: TextStyle(color: color, fontSize: 15.5)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
    );
  }
}
