import 'package:flutter/material.dart';
import 'package:gicc/providers/events_provider.dart';
import 'package:gicc/widgets/event_widgets/modern_event_card.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  EventsScreenState createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          final events = eventProvider.events;

          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'No events available',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Check back later for upcoming events',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Add refresh functionality here if needed
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ModernEventCard(
                  event: event,
                  onTap: () {
                    // TODO: Navigate to event details
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
