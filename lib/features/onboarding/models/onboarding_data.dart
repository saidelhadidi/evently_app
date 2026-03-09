import 'package:evently_app/core/resources/assets_manager.dart';

class OnBoardingData {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingData({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  static List<OnBoardingData> onBoardingScreens = [
    OnBoardingData(
      image: AssetsManager.onBoardingImage1,
      title: 'Find Events That Inspire You',
      subTitle:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),
    OnBoardingData(
      image: AssetsManager.onBoardingImage2,
      title: "Effortless Event Planning",
      subTitle:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    OnBoardingData(
      image: AssetsManager.onBoardingImage3,
      title: "Connect with Friends & Share Moments",
      subTitle:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];
}
