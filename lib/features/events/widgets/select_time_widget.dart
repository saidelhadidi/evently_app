import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../providers/event_provider.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          Icons.date_range,
          color: Theme.of(context).primaryColor,
        ),
        Text(
          StringsManager.eventDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Spacer(),
        Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            return GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365 * 5),
                  ),
                );
                if (pickedDate != null) {
                  eventProvider.changeDate(pickedDate);
                }
              },
              child: Text(
                eventProvider.selectedDate != null
                    ? "${eventProvider.selectedDate!.day}/${eventProvider.selectedDate!.month}/${eventProvider.selectedDate!.year}"
                    : StringsManager.chooseDate,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(
                    context,
                  ).primaryColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
