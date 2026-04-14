import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../providers/event_provider.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          StringsManager.eventTime,
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
                              mode: CupertinoDatePickerMode.time,
                              initialDateTime: DateTime(
                                2024, 1, 1,
                                eventProvider.selectedTime?.hour ?? TimeOfDay.now().hour,
                                eventProvider.selectedTime?.minute ?? TimeOfDay.now().minute,
                              ),
                              onDateTimeChanged: (DateTime newDateTime) {
                                eventProvider.changeTime(
                                  TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute),
                                );
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
                eventProvider.selectedTime != null
                    ? eventProvider.selectedTime!.format(context)
                    : StringsManager.chooseTime,
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
