import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/core/widgets/custom_text_field.dart';
import 'package:evently_app/features/events/widgets/update_event_button.dart';
import 'package:evently_app/features/events/widgets/header_picture.dart';
import 'package:evently_app/features/events/widgets/select_category_list.dart';
import 'package:evently_app/features/events/widgets/select_date_widget.dart';
import 'package:evently_app/features/events/widgets/select_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/categories_list.dart';
import '../../core/models/event_model.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../providers/event_provider.dart';

class EditEvent extends StatelessWidget {
  static const String routeName = "edit_event";

  const EditEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const CustomBackButton(),
        title: Text(StringsManager.editEvent),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer<EventProvider>(
              builder: (context, eventProvider, child) {
                final selectedCategory = CategoriesList.categories.firstWhere(
                  (category) => category.id == eventProvider.selectedCategoryId,
                  orElse: () => CategoriesList.categories[1],
                );
                return HeaderPicture(category: selectedCategory);
              },
            ),
            SelectCategoryList(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringsManager.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: Provider.of<EventProvider>(
                        context,
                        listen: false,
                      ).titleController,
                      hintText: StringsManager.eventTitleHint,
                    ),
                    const SizedBox(height: 8),

                    Text(
                      StringsManager.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: Provider.of<EventProvider>(
                        context,
                        listen: false,
                      ).descriptionController,
                      hintText: StringsManager.eventDescriptionHint,
                      minLines: 7,
                      maxLines: 7,
                    ),
                    const SizedBox(height: 16),
                    SelectTimeWidget(),
                    const SizedBox(height: 16),
                    SelectDateWidget(),
                  ],
                ),
              ),
            ),
            UpdateEventButton(event: event),
          ],
        ),
      ),
    );
  }
}
