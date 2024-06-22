import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;

  const DateTimePickerWidget({
    super.key,
    required this.label,
    this.selectedDate,
    this.selectedTime,
    required this.onDateTap,
    required this.onTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onDateTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? DateFormat('MM/dd/yyyy').format(selectedDate!)
                        : 'Date',
                    style: const TextStyle(fontSize: 16),
                  ),
                  selectedDate != null
                      ? const SizedBox.shrink()
                      : Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Colors.black.withOpacity(0.3),
                        )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: onTimeTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime != null
                        ? selectedTime!.format(context)
                        : 'Time',
                    style: const TextStyle(fontSize: 16),
                  ),
                  selectedTime != null
                      ? const SizedBox.shrink()
                      : Icon(
                          Icons.access_time,
                          size: 20,
                          color: Colors.black.withOpacity(0.3),
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
