import 'package:flutter/material.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/utils/validators/app_validator.dart';
import 'package:newsapp/core/widgets/custom_elevated_button.dart';
import 'package:newsapp/core/widgets/custom_text_form_field.dart';
import 'package:newsapp/features/auth/presentation/controller/auth_provider.dart';
import 'package:newsapp/features/auth/presentation/widget/auth_background.dart';
import 'package:newsapp/features/auth/presentation/widget/auth_footer.dart';
import 'package:newsapp/features/auth/presentation/widget/auth_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> keyform = GlobalKey<FormState>();

  late final AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    authProvider =  getIt<AuthProvider>();
    
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              key: keyform,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.ph80),
                  const AuthHeader(),
                  SizedBox(height: AppSizes.ph20),

                  CustomTextFormFields(
                    hintText: ConstantText.hint,
                    title: ConstantText.email,
                    controller: emailController,
                    validator: authProvider.validateEmail,
                  ),
                  SizedBox(height: AppSizes.ph16),

                  CustomTextFormFields(
                    hintText: '••••••••',
                    title: ConstantText.password,
                    controller: passwordController,
                    validator: authProvider.validatePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: AppSizes.ph20),

                  CustomTextFormFields(
                    hintText: '••••••••',
                    title: ConstantText.confirmpassword,
                    controller: confirmPasswordController,
                    validator: (value) => AppValidator.confirmPasswordValidator(
                      value,
                      passwordController.text,
                    ),
                    obscureText: true,
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
                                  if (!keyform.currentState!.validate()) return;

                                  final success = await authProvider.register(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );

                                  if (!context.mounted) return;

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Account created! Please login',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          authProvider.error ??
                                              'Registration failed',
                                        ),
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
                              : const Text(ConstantText.signup),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: AppSizes.ph20),
                  AuthFooter(
                    text: ConstantText.haveanaccount,
                    actionText: ConstantText.signIn,
                    route: '/login',
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
