import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gicc/widgets/resusable_widgets/customtextformfield.dart';
import 'package:gicc/widgets/resusable_widgets/datetimepicker_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key});

  @override
  AddEventDialogState createState() => AddEventDialogState();
}

class AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _pickDate(BuildContext context,
      {required bool isStartDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null &&
        pickedDate != _startDate &&
        pickedDate != _endDate)
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
  }

  Future<void> _pickTime(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null &&
        pickedTime != _startTime &&
        pickedTime != _endTime)
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Event', style: GoogleFonts.aBeeZee()),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
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
              if (_image != null)
                Image.file(
                  _image!,
                  width: 100,
                  height: 100,
                ),
              SizedBox(
                width: 700,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _titleController,
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
                      controller: _descriptionController,
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
                      controller: _locationController,
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
                selectedDate: _startDate,
                selectedTime: _startTime,
                onDateTap: () => _pickDate(context, isStartDate: true),
                onTimeTap: () => _pickTime(context, isStartTime: true),
              ),
              const SizedBox(height: 16),
              DateTimePickerWidget(
                label: 'End Date and Time',
                selectedDate: _endDate,
                selectedTime: _endTime,
                onDateTap: () => _pickDate(context, isStartDate: false),
                onTimeTap: () => _pickTime(context, isStartTime: false),
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
            if (_formKey.currentState?.validate() ?? false) {
              // Handle the submit action
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
