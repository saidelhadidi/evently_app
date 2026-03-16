import 'package:evently_app/features/favorites/widgets/custom_search_bar.dart';
import 'package:evently_app/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/event_card.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(),
            const SizedBox(height: 16),
            Consumer<EventProvider>(
              builder: (context, provider, child) {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: provider.favEvents.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return EventCard(event: provider.favEvents[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
