import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:evently_app/core/widgets/custom_text_field.dart';
import 'package:evently_app/features/events/widgets/add_event_button.dart';
import 'package:evently_app/features/events/widgets/header_picture.dart';
import 'package:evently_app/features/events/widgets/select_category_list.dart';
import 'package:evently_app/features/events/widgets/select_date_widget.dart';
import 'package:evently_app/features/events/widgets/select_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/categories_list.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../providers/event_provider.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  static const String routeName = "add_event_screen";

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          eventProvider.resetValues();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 60,
          leading: const CustomBackButton(),
          title: Text(StringsManager.addEvent),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: eventProvider.formKey,
              child: Column(
                children: [
                  Consumer<EventProvider>(
                    builder: (context, eventProvider, child) {
                      final selectedCategory = CategoriesList.categories.firstWhere(
                        (category) =>
                            category.id == eventProvider.selectedCategoryId,
                        orElse: () => CategoriesList.categories[1],
                      );

                      return HeaderPicture(category: selectedCategory);
                    },
                  ),
                  const SelectCategoryList(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringsManager.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: eventProvider.titleController,
                          hintText: StringsManager.eventTitleHint,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return StringsManager.eventTitleRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          StringsManager.description,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: eventProvider.descriptionController,
                          hintText: StringsManager.eventDescriptionHint,
                          minLines: 7,
                          maxLines: 7,
                        ),
                        const SizedBox(height: 16),
                        const SelectTimeWidget(),
                        const SizedBox(height: 16),
                        const SelectDateWidget(),
                      ],
                    ),
                  ),
                  const AddEventButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
