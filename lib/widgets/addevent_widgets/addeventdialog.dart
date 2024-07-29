import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gicc/providers/events_provider.dart';
import 'package:gicc/widgets/resusable_widgets/customtextformfield.dart';
import 'package:gicc/widgets/resusable_widgets/datetimepicker_widget.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key});

  @override
  AddEventDialogState createState() => AddEventDialogState();
}

class AddEventDialogState extends State<AddEventDialog> {
  @override
  Widget build(BuildContext context) {
    final eventnotifier = context.watch<EventProvider>();
    return AlertDialog(
      title: Text('Add Event', style: GoogleFonts.aBeeZee()),
      content: SingleChildScrollView(
        child: Form(
          key: eventnotifier.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  eventnotifier.pickImage();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: DottedBorder(
                    color: Colors.black.withOpacity(0.3),
                    dashPattern: const [8, 4],
                    strokeWidth: 8,
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo_outlined),
                          Text(
                            'Add Event Image',
                            style: GoogleFonts.aBeeZee(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (eventnotifier.image != null)
                Image.file(
                  eventnotifier.image!,
                  width: 100,
                  height: 100,
                ),
              SizedBox(
                width: 700,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: eventnotifier.titleController,
                      hintText: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormField(
                      controller: eventnotifier.descriptionController,
                      hintText: 'Description',
                      maxlines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormField(
                      controller: eventnotifier.locationController,
                      hintText: 'Location',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Location';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DateTimePickerWidget(
                label: 'Start Date and Time',
                selectedDate: eventnotifier.startDate,
                selectedTime: eventnotifier.startTime,
                onDateTap: () =>
                    eventnotifier.pickDate(context, isStartDate: true),
                onTimeTap: () =>
                    eventnotifier.pickTime(context, isStartTime: true),
              ),
              const SizedBox(height: 16),
              DateTimePickerWidget(
                label: 'End Date and Time',
                selectedDate: eventnotifier.endDate,
                selectedTime: eventnotifier.endTime,
                onDateTap: () =>
                    eventnotifier.pickDate(context, isStartDate: false),
                onTimeTap: () =>
                    eventnotifier.pickTime(context, isStartTime: false),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (eventnotifier.formKey.currentState?.validate() ?? false) {
              // Handle the submit action
              eventnotifier.addEvent();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
