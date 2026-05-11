import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/core/constant/app_sizes.dart';
import 'package:newsapp/core/constant/asset_image.dart';
import 'package:newsapp/core/constant/constant_text.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/widgets/custom_elevated_button.dart';
import 'package:newsapp/core/widgets/custom_text_form_field.dart';
import 'package:newsapp/features/auth/presentation/controller/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 
  final AuthProvider authProvider = getIt<AuthProvider>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(AssetsImage.logo, height: AppSizes.h45),
                ),
                SizedBox(height: AppSizes.ph20),
                Text(
                  ConstantText.welcome,
                  style: TextStyle(
                    fontSize: AppSizes.sp20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

               
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
                  obsecureText: true,
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
                                if (!_formKey.currentState!.validate()) return;

                               
                                final success = await authProvider.login(
                                  emailController.text,
                                  passwordController.text,
                                );

                                if (!success &&
                                    authProvider.error != null &&
                                    context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(authProvider.error!),
                                    ),
                                  );
                                }
                              },
                        label: const Text(ConstantText.signIn),
                      ),
                    );
                  },
                ),

                SizedBox(height: AppSizes.ph20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(ConstantText.donthaveaccount),
                    SizedBox(width: AppSizes.pw8),
                    InkWell(
                      onTap: () => context.go('/register'),
                      child: const Text(
                        ConstantText.signup,
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
}
