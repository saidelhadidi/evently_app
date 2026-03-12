import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/event_model.dart';
import '../../../core/widgets/custom_primary_button.dart';
import '../../../providers/event_provider.dart';

class UpdateEventButton extends StatelessWidget {
  final EventModel event;
  const UpdateEventButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomPrimaryButton(
        title: StringsManager.updateEvent,
        onPressed: () {
          final eventProvider = Provider.of<EventProvider>(
            context,
            listen: false,
          );
          String title = eventProvider.titleController.text;

          if (title.isEmpty ||
              eventProvider.selectedDate == null ||
              eventProvider.selectedTime == null) {
            return;
          }

          eventProvider.updateEvent(event.id);
          Navigator.pop(context);
        },
      ),
    );
  }
}