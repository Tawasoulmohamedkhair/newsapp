import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/asset_image.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/utils/validators/app_validator.dart';
import 'package:newsapp/core/widgets/custom_elevated_button.dart';
import 'package:newsapp/core/widgets/custom_text_form_field.dart';
import 'package:newsapp/features/auth/presentation/controller/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmePasswordController =
      TextEditingController();
  final GlobalKey<FormState> keyform = GlobalKey<FormState>();

  final AuthProvider authProvider = getIt<AuthProvider>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsImage.news),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Form(
            key: keyform,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(AssetsImage.logo, height: 45)),
                SizedBox(height: AppSizes.ph20),
                Text(
                  ConstantText.welcome,
                  style: TextStyle(
                    fontSize: AppSizes.sp20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

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
                  obsecureText: true,
                ),

                SizedBox(height: AppSizes.ph20),

                CustomTextFormFields(
                  hintText: '••••••••',
                  title: ConstantText.confirmpassword,
                  controller: confirmePasswordController,
                  validator: (value) => AppValidator.confirmPasswordValidator(
                    value,
                    passwordController.text,
                  ),
                  obsecureText: true,
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

                                if (success) {
                                  
                                  if (context.mounted) {
                                    context.go('/login');
                                  }
                                } else {
                                  // عرض رسالة الخطأ
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        authProvider.error ??
                                            'Registration failed',
                                      ),
                                    ),
                                  );
                                }
                              },
                        label: Text(ConstantText.signup),
                      ),
                    );
                  },
                ),

                SizedBox(height: AppSizes.ph20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ConstantText.haveanaccount),
                    SizedBox(width: AppSizes.pw8),
                    InkWell(
                      onTap: () => context.go('/login'),
                      child: const Text(
                        ConstantText.signIn,
                        style: TextStyle(
                          color: Color(0xffC53030),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _submitRegister() async {
    if (!keyform.currentState!.validate()) return;

    final success = await authProvider.register(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!success && authProvider.error != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(authProvider.error!)));
    } else if (success && context.mounted) {
      context.go('/login');
    }
  }
}
