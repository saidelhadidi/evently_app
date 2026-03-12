import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/features/events/edit_event.dart';
import 'package:evently_app/features/events/widgets/action_button.dart';
import 'package:evently_app/features/events/widgets/event_description_label.dart';
import 'package:evently_app/features/events/widgets/event_time_label.dart';
import 'package:evently_app/features/events/widgets/header_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/event_model.dart';
import '../../core/resources/strings_manager.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../providers/event_provider.dart';

class EventDetails extends StatelessWidget {
  static const String routeName = "event_details";

  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final initialEvent =
        ModalRoute.of(context)!.settings.arguments as EventModel;
    final eventProvider = Provider.of<EventProvider>(context);
    final event = eventProvider.allEvents.firstWhere(
      (e) => e.id == initialEvent.id,
      orElse: () => initialEvent,
    );
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        leading: const CustomBackButton(),
        title: Text(StringsManager.eventDetails),
        actions: [
          ActionButton(
            icon: AssetsManager.editIcon,
            onTap: () {
              Provider.of<EventProvider>(
                context,
                listen: false,
              ).loadEventData(event);
              Navigator.pushNamed(
                context,
                EditEvent.routeName,
                arguments: event,
              );
            },
          ),
          ActionButton(
            iconColor: Theme.of(context).colorScheme.error,
            icon: AssetsManager.deleteIcon,
            onTap: () {
              Provider.of<EventProvider>(
                context,
                listen: false,
              ).deleteEvent(event.id);
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            HeaderPicture(category: event.category),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  EventTimeLabel(eventDate: event.dateTime),
                  const SizedBox(height: 16),
                  Text(
                    StringsManager.description,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  EventDescriptionLabel(description: event.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
