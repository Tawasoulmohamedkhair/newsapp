import 'package:flutter/material.dart';

class CustomTextFormFields extends StatelessWidget {
  const CustomTextFormFields({
    super.key,
    required this.title,
    this.validator,
    this.suffixe,

    this.maxLines,
    required this.hintText,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? hintText;
  final Widget? suffixe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 8),
        SizedBox(
          width: 343,
          height: 56,
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: Theme.of(context).textTheme.labelMedium,

            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              suffix: suffixe,
            ),
          ),
        ),
      ],
    );
  }
}
