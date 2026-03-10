import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/resources/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {},
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(AssetsManager.selectedHome),
                icon: SvgPicture.asset(AssetsManager.home),
                label: StringsManager.home,
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(AssetsManager.selectedFavourite),
                icon: SvgPicture.asset(AssetsManager.favourite),
                label: StringsManager.favourite,
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(AssetsManager.selectedProfile),
                icon: SvgPicture.asset(AssetsManager.profile),
                label: StringsManager.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
