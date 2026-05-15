import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/widgets/custom_elevated_button.dart';
import 'package:newsapp/core/widgets/custom_text_form_field.dart';
import 'package:newsapp/features/auth/presentation/controller/auth_provider.dart';
import 'package:newsapp/features/auth/presentation/widget/auth_background.dart';
import 'package:newsapp/features/auth/presentation/widget/auth_footer.dart';
import 'package:newsapp/features/auth/presentation/widget/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final AuthProvider authProvider;
   @override
  void initState() {
    super.initState();
    
    authProvider = getIt<AuthProvider>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: AppSizes.ph80),
                  const AuthHeader(),
                  SizedBox(height: AppSizes.ph20),
                  CustomTextFormFields(
                    title: ConstantText.email,
                    hintText: ConstantText.hint,
                    controller: emailController,
                    validator: authProvider.validateEmail,
                  ),
                  SizedBox(height: AppSizes.ph20),
                  CustomTextFormFields(
                    title: ConstantText.password,
                    hintText: '••••••••',
                    controller: passwordController,
                    obscureText: true,
                    validator: authProvider.validatePassword,
                  ),
                  SizedBox(height: AppSizes.ph20),

                  ListenableBuilder(
                    listenable: authProvider,
                    builder: (context, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSizes.h48,
                        child: CustomElevatedButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  final success = await authProvider.login(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                  if (!success &&
                                      authProvider.error != null &&
                                      context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(authProvider.error!),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                          label: authProvider.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(ConstantText.signIn),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: AppSizes.ph20),
                  AuthFooter(
                    text: ConstantText.donthaveaccount,
                    actionText: ConstantText.signup,
                    route: '/register',
                  ),
                  SizedBox(height: AppSizes.ph40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
