import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';

class OnBoardingData {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingData({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  static List<OnBoardingData> get onBoardingScreens => [
        OnBoardingData(
          image: AssetsManager.onBoardingImage1,
          title: StringsManager.onBoardingTitle1,
          subTitle: StringsManager.onBoardingSubTitle1,
        ),
        OnBoardingData(
          image: AssetsManager.onBoardingImage2,
          title: StringsManager.onBoardingTitle2,
          subTitle: StringsManager.onBoardingSubTitle2,
        ),
        OnBoardingData(
          image: AssetsManager.onBoardingImage3,
          title: StringsManager.onBoardingTitle3,
          subTitle: StringsManager.onBoardingSubTitle3,
        ),
      ];
}
