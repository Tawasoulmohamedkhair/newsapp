import 'package:flutter/material.dart';
import 'package:newsapp/features/onboarding/controller/onboarding_controller.dart';
import 'package:newsapp/features/onboarding/model/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController(),
      builder: (context, child) {
        final controller = context.read<OnboardingController>();

        return Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          appBar: AppBar(
            backgroundColor: Color(0xfff5f5f5),
            actions: [
              Consumer<OnboardingController>(
                builder:
                    (
                      BuildContext context,
                      OnboardingController value,
                      Widget? child,
                    ) {
                      return value.isLastPage
                          ? SizedBox()
                          : TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Color(0xffC53030),
                              ),
                              onPressed: () {
                                controller.onFinish(context);
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                    },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (int index) {
                      context.read<OnboardingController>().onPageChanged(index);
                    },
                    itemCount: OnboardingModel.onboardingdata.length,
                    itemBuilder: (context, index) {
                      final model = OnboardingModel.onboardingdata[index];

                      return Column(
                        children: [
                          Expanded(child: Image.asset(model.image)),
                          Text(
                            model.title,
                            style: TextStyle(
                              color: Color(0xff4E4B66),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            model.description,
                            style: TextStyle(
                              color: Color(0xff6E7191),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (context, value, child) {
                    return SmoothPageIndicator(
                      controller: controller.pageController, // PageController
                      count: 3,
                      effect: SwapEffect(
                        activeDotColor: Color(0xffC53030),
                        dotColor: Color(0xffD3D3D3).withValues(alpha: 0.3),
                        dotHeight: 12,
                        dotWidth: 12,
                      ), // your preferred effect
                      onDotClicked: (index) {},
                    );
                  },
                ),
                SizedBox(
                  height: 52,
                  width: double.infinity,

                  child: Consumer<OnboardingController>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffC53030),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          if (!value.isLastPage) {
                            controller.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            controller.onFinish(context);
                          }
                        },
                        child: Text(value.isLastPage ? "Get Started" : "Next"),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/onboarding_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
