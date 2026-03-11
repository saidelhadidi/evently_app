import 'package:evently_app/features/home/widgets/categories_list_widget.dart';
import 'package:evently_app/features/home/widgets/home_header_widget.dart';
import 'package:flutter/material.dart';

import '../../core/constants/categories_list.dart';
import '../../core/models/event_model.dart';
import '../../core/widgets/event_card.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  final List<EventModel> dummyEvents = [
    EventModel(
      id: "1",
      title: "Google Tech Workshop",
      description: "A 3-day technical workshop for developers.",
      category: CategoriesList.categories[4],
      dateTime: DateTime.now(),
      location: "Google Office, Dubai",
      isFavorite: true,
    ),
    EventModel(
      id: "1",
      title: "Google Tech Workshop",
      description: "A 3-day technical workshop for developers.",
      category: CategoriesList.categories[3],
      dateTime: DateTime(2026, 4, 9, 10, 0),
      location: "Google Office, Dubai",
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HomeHeaderWidget(),
          CategoriesListWidget(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: dummyEvents.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return EventCard(event: dummyEvents[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
