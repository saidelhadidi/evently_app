import 'package:evently_app/core/theme/app_colors.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/header_image.dart';
import 'package:evently_app/features/auth/log_in_screen.dart';
import 'package:evently_app/features/onboarding/models/onboarding_data.dart';
import 'package:evently_app/features/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "onBoarding_screen";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeaderImage(),
        centerTitle: true,
        leadingWidth: 66,
        leading: currentIndex > 0
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              )
            : null,
        actions: [
          if (currentIndex < 2)
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    LogInScreen.routeName,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Skip",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: .topStart,
            children: [
              PageView.builder(
                itemBuilder: (context, index) {
                  return OnBoardingItem(
                    model: OnBoardingData.onBoardingScreens[index],
                  );
                },
                itemCount: OnBoardingData.onBoardingScreens.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                controller: _pageController,
              ),
              Align(
                alignment: .center,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: OnBoardingData.onBoardingScreens.length,
                  effect: WormEffect(activeDotColor: AppColors.lightMain),
                ),
              ),
              Align(
                alignment: .bottomCenter,
                child: CustomPrimaryButton(
                  title: currentIndex == 2 ? "Let's Start" : "Next",
                  onPressed: () {
                    currentIndex < OnBoardingData.onBoardingScreens.length - 1
                        ? _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          )
                        : {
                            Navigator.pushReplacementNamed(
                              context,
                              LogInScreen.routeName,
                            ),
                          };
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
