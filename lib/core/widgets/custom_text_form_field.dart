// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';

class CustomTextFormFields extends StatefulWidget {
  const CustomTextFormFields({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    this.maxLines = 1,
    required this.hintText,
    this.suffixe,
    this.obscureText = false,
  });
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? hintText;
  final Widget? suffixe;
  final bool obscureText;

  @override
  State<CustomTextFormFields> createState() => _CustomTextFormFieldsState();
}

class _CustomTextFormFieldsState extends State<CustomTextFormFields> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.displaySmall),
         SizedBox(height: AppSizes.ph8),
        SizedBox(
          width: AppSizes.w343,
          height: AppSizes.h56,
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText && !isPasswordVisible,
            validator: widget.validator,
            style: Theme.of(context).textTheme.labelMedium,

            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: widget.hintText,
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
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
