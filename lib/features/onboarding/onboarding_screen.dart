import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/core/widgets/custom_primary_button.dart';
import 'package:evently_app/core/widgets/header_image.dart';
import 'package:evently_app/features/auth/log_in_screen.dart';
import 'package:evently_app/features/onboarding/models/onboarding_data.dart';
import 'package:evently_app/features/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/resources/size_manager.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../providers/onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = "onBoarding_screen";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const HeaderImage(),
            centerTitle: true,
            leadingWidth: 66,
            leading: Consumer<OnboardingProvider>(
              builder: (context, provider, child) {
                return provider.currentIndex > 0
                    ? CustomBackButton(
                        onTap: () {
                          provider.pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      )
                    : const SizedBox();
              },
            ),
            actions: [
              Consumer<OnboardingProvider>(
                builder: (context, provider, child) {
                  if (provider.currentIndex < 2) {
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;

                    return Padding(
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
                            color: isDark
                                ? Colors.transparent
                                : AppColors.lightInputs,
                            borderRadius: BorderRadius.circular(8),
                            border: isDark
                                ? Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1,
                                  )
                                : null,
                          ),
                          child: Text(
                            StringsManager.skip,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.lightInputs
                                      : Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: OnBoardingData.onBoardingScreens.length,
                          controller: context
                              .read<OnboardingProvider>()
                              .pageController,
                          onPageChanged: (index) {
                            context.read<OnboardingProvider>().changeIndex(
                              index,
                            );
                          },
                          itemBuilder: (context, index) {
                            return OnBoardingItem(
                              model: OnBoardingData.onBoardingScreens[index],
                            );
                          },
                        ),
                        Positioned(
                          top: SizeManager.getScreenHeight(context) * 0.47,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Consumer<OnboardingProvider>(
                              builder: (context, provider, child) {
                                return SmoothPageIndicator(
                                  controller: provider.pageController,
                                  count:
                                      OnBoardingData.onBoardingScreens.length,
                                  effect: WormEffect(
                                    activeDotColor: Theme.of(
                                      context,
                                    ).primaryColor,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<OnboardingProvider>(
                    builder: (context, provider, child) {
                      return CustomPrimaryButton(
                        title: provider.currentIndex == 2
                            ? StringsManager.getStarted
                            : StringsManager.next,
                        onPressed: () {
                          if (provider.currentIndex <
                              OnBoardingData.onBoardingScreens.length - 1) {
                            provider.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pushReplacementNamed(
                              context,
                              LogInScreen.routeName,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
