import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../providers/event_provider.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.date_range,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          StringsManager.eventDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            return GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => Container(
                    height: 300,
                    padding: const EdgeInsets.only(bottom: 16),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: SafeArea(
                      top: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime:
                                  eventProvider.selectedDate ?? DateTime.now(),
                              minimumDate: DateTime.now(),
                              maximumDate: DateTime.now()
                                  .add(const Duration(days: 365 * 5)),
                              onDateTimeChanged: (DateTime newDate) {
                                eventProvider.changeDate(newDate);
                              },
                            ),
                          ),
                          CupertinoButton(
                            child: const Text('Done'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                eventProvider.selectedDate != null
                    ? "${eventProvider.selectedDate!.day}/${eventProvider.selectedDate!.month}/${eventProvider.selectedDate!.year}"
                    : StringsManager.chooseDate,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
