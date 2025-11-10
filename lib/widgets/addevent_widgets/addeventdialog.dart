import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:gicc/providers/events_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key});

  @override
  AddEventDialogState createState() => AddEventDialogState();
}

class AddEventDialogState extends State<AddEventDialog> {
  bool _isLoading = false;

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not selected';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'Not selected';
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final eventnotifier = context.watch<EventProvider>();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.event_note,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            'Add New Event',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: eventnotifier.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Upload Section
                Center(
                  child: GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () async {
                            await eventnotifier.pickImage();
                            setState(() {}); // Refresh to show image
                          },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.cardRadius),
                            color: eventnotifier.image != null
                                ? Colors.transparent
                                : AppColors.primary.withValues(alpha: 0.05),
                          ),
                          child: eventnotifier.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.cardRadius),
                                  child: Image.file(
                                    eventnotifier.image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : DottedBorder(
                                  color:
                                      AppColors.primary.withValues(alpha: 0.4),
                                  dashPattern: const [8, 4],
                                  strokeWidth: 2,
                                  borderType: BorderType.RRect,
                                  radius:
                                      Radius.circular(AppSpacing.cardRadius),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 48,
                                          color: AppColors.primary
                                              .withValues(alpha: 0.6),
                                        ),
                                        const SizedBox(height: AppSpacing.sm),
                                        Text(
                                          'Add Event Image',
                                          style:
                                              AppTextStyles.bodyMedium.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          '(Optional)',
                                          style:
                                              AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        if (eventnotifier.image != null)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    eventnotifier.image = null;
                                  });
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Title Field
                TextFormField(
                  controller: eventnotifier.titleController,
                  decoration: InputDecoration(
                    labelText: 'Event Title',
                    hintText: 'Enter event title',
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.borderRadiusSm),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an event title';
                    }
                    if (value.length < 3) {
                      return 'Title must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                // Description Field
                TextFormField(
                  controller: eventnotifier.descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter event description',
                    prefixIcon: const Icon(Icons.description_outlined),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.borderRadiusSm),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.length < 10) {
                      return 'Description must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                // Location Field
                TextFormField(
                  controller: eventnotifier.locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Enter event location',
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.borderRadiusSm),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // Date & Time Section Header
                Text(
                  'Event Schedule',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Start Date & Time
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusSm),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.event_available,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'Start Date & Time',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await eventnotifier.pickDate(
                                  context,
                                  isStartDate: true,
                                );
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.sm,
                                  horizontal: AppSpacing.md,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.borderRadiusSm),
                                  border: Border.all(
                                    color: eventnotifier.startDate == null
                                        ? Colors.red.withValues(alpha: 0.5)
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color: eventnotifier.startDate == null
                                          ? Colors.red.withValues(alpha: 0.7)
                                          : AppColors.primary,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        _formatDate(eventnotifier.startDate),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: eventnotifier.startDate == null
                                              ? Colors.red
                                                  .withValues(alpha: 0.7)
                                              : AppColors.textPrimary,
                                          fontWeight:
                                              eventnotifier.startDate == null
                                                  ? FontWeight.normal
                                                  : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await eventnotifier.pickTime(
                                  context,
                                  isStartTime: true,
                                );
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.sm,
                                  horizontal: AppSpacing.md,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.borderRadiusSm),
                                  border: Border.all(
                                    color: eventnotifier.startTime == null
                                        ? Colors.red.withValues(alpha: 0.5)
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 18,
                                      color: eventnotifier.startTime == null
                                          ? Colors.red.withValues(alpha: 0.7)
                                          : AppColors.primary,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        _formatTime(eventnotifier.startTime),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: eventnotifier.startTime == null
                                              ? Colors.red
                                                  .withValues(alpha: 0.7)
                                              : AppColors.textPrimary,
                                          fontWeight:
                                              eventnotifier.startTime == null
                                                  ? FontWeight.normal
                                                  : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // End Date & Time
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.borderRadiusSm),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.event_busy,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'End Date & Time',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await eventnotifier.pickDate(
                                  context,
                                  isStartDate: false,
                                );
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.sm,
                                  horizontal: AppSpacing.md,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.borderRadiusSm),
                                  border: Border.all(
                                    color: eventnotifier.endDate == null
                                        ? Colors.red.withValues(alpha: 0.5)
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color: eventnotifier.endDate == null
                                          ? Colors.red.withValues(alpha: 0.7)
                                          : AppColors.primary,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        _formatDate(eventnotifier.endDate),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: eventnotifier.endDate == null
                                              ? Colors.red
                                                  .withValues(alpha: 0.7)
                                              : AppColors.textPrimary,
                                          fontWeight:
                                              eventnotifier.endDate == null
                                                  ? FontWeight.normal
                                                  : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await eventnotifier.pickTime(
                                  context,
                                  isStartTime: false,
                                );
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.sm,
                                  horizontal: AppSpacing.md,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.borderRadiusSm),
                                  border: Border.all(
                                    color: eventnotifier.endTime == null
                                        ? Colors.red.withValues(alpha: 0.5)
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 18,
                                      color: eventnotifier.endTime == null
                                          ? Colors.red.withValues(alpha: 0.7)
                                          : AppColors.primary,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        _formatTime(eventnotifier.endTime),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: eventnotifier.endTime == null
                                              ? Colors.red
                                                  .withValues(alpha: 0.7)
                                              : AppColors.textPrimary,
                                          fontWeight:
                                              eventnotifier.endTime == null
                                                  ? FontWeight.normal
                                                  : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: _isLoading ? Colors.grey : AppColors.textSecondary,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () async {
                  // Validate form
                  if (!eventnotifier.formKey.currentState!.validate()) {
                    return;
                  }

                  // Validate dates and times
                  if (eventnotifier.startDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a start date'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (eventnotifier.startTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a start time'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (eventnotifier.endDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an end date'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (eventnotifier.endTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an end time'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Check if end date/time is after start date/time
                  final startDateTime = DateTime(
                    eventnotifier.startDate!.year,
                    eventnotifier.startDate!.month,
                    eventnotifier.startDate!.day,
                    eventnotifier.startTime!.hour,
                    eventnotifier.startTime!.minute,
                  );

                  final endDateTime = DateTime(
                    eventnotifier.endDate!.year,
                    eventnotifier.endDate!.month,
                    eventnotifier.endDate!.day,
                    eventnotifier.endTime!.hour,
                    eventnotifier.endTime!.minute,
                  );

                  if (endDateTime.isBefore(startDateTime) ||
                      endDateTime.isAtSameMomentAs(startDateTime)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('End date/time must be after start date/time'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Show loading
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await eventnotifier.addEvent();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Event added successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error adding event: ${e.toString()}'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 4),
                        ),
                      );
                    }
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Add Event'),
        ),
      ],
    );
  }
}
