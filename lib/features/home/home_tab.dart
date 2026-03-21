import 'package:evently_app/features/home/widgets/categories_list_widget.dart';
import 'package:evently_app/features/home/widgets/home_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/event_card.dart';
import '../../providers/event_provider.dart';
import '../../providers/home_provider.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "home_tab";

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: SafeArea(
        child: Column(
          children: [
            HomeHeaderWidget(),
            CategoriesListWidget(),
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
      ),
    );
  }
}
