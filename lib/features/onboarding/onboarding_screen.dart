import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/header_image.dart';
import 'package:evently_app/features/auth/log_in_screen.dart';
import 'package:evently_app/features/onboarding/models/onboarding_data.dart';
import 'package:evently_app/features/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../providers/onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = "onBoarding_screen";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const HeaderImage(),
        centerTitle: true,
        leadingWidth: 66,
        leading: provider.currentIndex > 0
            ? CustomBackButton(
                onTap: () {
                  provider.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              )
            : null,
        actions: [
          if (provider.currentIndex < 2)
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    StringsManager.skip,
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
                  provider.changeIndex(index);
                },
                controller: provider.pageController,
              ),
              Align(
                alignment: .center,
                child: SmoothPageIndicator(
                  controller: provider.pageController,
                  count: OnBoardingData.onBoardingScreens.length,
                  effect: WormEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Align(
                alignment: .bottomCenter,
                child: CustomPrimaryButton(
                  title: provider.currentIndex == 2 ? "Let's Start" : "Next",
                  onPressed: () {
                    provider.currentIndex <
                            OnBoardingData.onBoardingScreens.length - 1
                        ? provider.pageController.nextPage(
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
