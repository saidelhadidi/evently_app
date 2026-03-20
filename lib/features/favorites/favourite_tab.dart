import 'package:evently_app/features/favorites/widgets/custom_search_bar.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/event_card.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              onChanged: (value) {
                context.read<EventProvider>().searchFavEvents(value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<EventProvider>(
                builder: (context, provider, child) {
                  final displayList = provider.searchQuery.isEmpty
                      ? provider.favEvents
                      : provider.searchFavResult;
                  if (displayList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No events found !",
                        style: TextStyle(fontSize: 18, color: AppColors.lightRed),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: displayList.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return EventCard(event: displayList[index]);
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