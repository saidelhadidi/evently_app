import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../providers/event_provider.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          Icons.access_time,
          color: Theme.of(context).primaryColor,
        ),
        Text(
          StringsManager.eventTime,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Spacer(),
        Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            return GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  eventProvider.changeTime(pickedTime);
                }
              },
              child: Text(
                eventProvider.selectedTime != null
                    ? eventProvider.selectedTime!.format(
                  context,
                )
                    : StringsManager.chooseTime,
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
