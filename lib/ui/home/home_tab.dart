import 'package:evently_app/ui/home/widgets/categories_list_widget.dart';
import 'package:evently_app/ui/home/widgets/home_header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/event_card.dart';
import '../../providers/event_provider.dart';
import '../../providers/home_provider.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        context.read<HomeProvider>().fetchUserData(uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HomeHeaderWidget(),
          const CategoriesListWidget(),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer2<HomeProvider, EventProvider>(
              builder: (context, homeProvider, eventProvider, child) {
                final filteredEvents = eventProvider.getFilteredEvents(
                  homeProvider.currentCategoryId,
                );

                if (filteredEvents.isEmpty) {
                  return const Center(child: Text("No events found !"));
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: filteredEvents.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return EventCard(event: filteredEvents[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
