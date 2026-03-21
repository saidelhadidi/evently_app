import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/categories_list.dart';
import '../../../core/models/event_model.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/widgets/custom_primary_button.dart';
import '../../../providers/event_provider.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomPrimaryButton(
        title: StringsManager.addEvent,
        onPressed: () {
          final eventProvider = Provider.of<EventProvider>(
            context,
            listen: false,
          );
          String title = eventProvider.titleController.text;
          String description = eventProvider.descriptionController.text;

          if (title.isEmpty ||
              eventProvider.selectedDate == null ||
              eventProvider.selectedTime == null) {
            return;
          }

          final fullDateTime = DateTime(
            eventProvider.selectedDate!.year,
            eventProvider.selectedDate!.month,
            eventProvider.selectedDate!.day,
            eventProvider.selectedTime!.hour,
            eventProvider.selectedTime!.minute,
          );

          final selectedCategoryModel = CategoriesList.categories.firstWhere(
            (cat) => cat.id == eventProvider.selectedCategoryId,
          );

          EventModel newEvent = EventModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            description: description,
            category: selectedCategoryModel,
            dateTime: fullDateTime,
          );

          eventProvider.addEvent(newEvent);
          eventProvider.resetValues();
          Navigator.pop(context);
        },
      ),
    );
  }
}
