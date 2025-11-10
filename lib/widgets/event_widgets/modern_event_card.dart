import 'package:flutter/material.dart';
import 'package:gicc/core/theme/design_system.dart';
import 'package:gicc/models/event_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

/// Modern event card widget with Material 3 design
///
/// Features:
/// - Hero image with gradient overlay
/// - Cached network images for performance
/// - Date badge with formatted display
/// - Location and time information
/// - Smooth tap interactions
/// - Theme-aware styling
class ModernEventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;
  final bool showFullDate;

  const ModernEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.showFullDate = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      elevation: AppElevation.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image with gradient overlay
            _buildHeroImage(context, isDark),

            // Event content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event title
                  Text(
                    event.title,
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Event description
                  Text(
                    event.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Event metadata (location, time)
                  _buildEventMetadata(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, bool isDark) {
    return Stack(
      children: [
        // Image
        AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            imageUrl: event.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: isDark ? AppColors.darkSurface : AppColors.surface,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: isDark ? AppColors.darkSurface : AppColors.surface,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.event,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'No Image',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),

        // Date badge
        Positioned(
          top: AppSpacing.md,
          right: AppSpacing.md,
          child: _buildDateBadge(),
        ),
      ],
    );
  }

  Widget _buildDateBadge() {
    final monthDay = DateFormat('MMM\ndd').format(event.startDate);
    final lines = monthDay.split('\n');

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            lines[0],
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            lines[1],
            style: AppTextStyles.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventMetadata(BuildContext context) {
    return Column(
      children: [
        // Date and time
        _buildMetadataRow(
          icon: Icons.calendar_today,
          text: showFullDate
              ? DateFormat('EEEE, MMMM d, y').format(event.startDate)
              : DateFormat('MMM d, y').format(event.startDate),
        ),
        const SizedBox(height: AppSpacing.xs),

        // Time
        _buildMetadataRow(
          icon: Icons.access_time,
          text:
              '${_formatTimeOfDay(event.startTime)} - ${_formatTimeOfDay(event.endTime)}',
        ),
        const SizedBox(height: AppSpacing.xs),

        // Location
        _buildMetadataRow(
          icon: Icons.location_on,
          text: event.location,
        ),
      ],
    );
  }

  Widget _buildMetadataRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
