import 'package:flutter/material.dart';
import 'package:newsapp/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/newspaper.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png', height: 45)),
              SizedBox(height: 20),
              Text(
                'Welcome to Newts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              CustomTextFormFields(
                hintText: 'usama@gmail.com',
                title: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 16),
              CustomTextFormFields(
                hintText: '••••••••',
                title: 'Password',
                controller: passwordController,
                suffixe: IconButton(
                  icon: isPasswordVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
