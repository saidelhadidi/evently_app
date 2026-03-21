import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/features/events/add_event.dart';
import 'package:evently_app/features/favorites/favourite_tab.dart';
import 'package:evently_app/features/home/home_tab.dart';
import 'package:evently_app/features/profile/profile_tab.dart';
import 'package:evently_app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/resources/assets_manager.dart';

class MainLayout extends StatelessWidget {
  static const String routeName = "main";

  const MainLayout({super.key});

  static List<Widget> tabs = [HomeTab(), FavouriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
        body: Selector<HomeProvider, int>(
          selector: (context, provider) => provider.currentIndex,
          builder: (context, currentIndex, child) {
            return tabs[currentIndex];
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddEvent.routeName);
          },
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
            child: Selector<HomeProvider, int>(
              selector: (context, provider) => provider.currentIndex,
              builder: (context, currentIndex, child) {
                return BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (index) {
                    context.read<HomeProvider>().changeIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(AssetsManager.selectedHome),
                      icon: SvgPicture.asset(AssetsManager.home),
                      label: StringsManager.home,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        AssetsManager.selectedFavourite,
                      ),
                      icon: SvgPicture.asset(AssetsManager.favourite),
                      label: StringsManager.favourite,
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        AssetsManager.selectedProfile,
                      ),
                      icon: SvgPicture.asset(AssetsManager.profile),
                      label: StringsManager.profile,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
