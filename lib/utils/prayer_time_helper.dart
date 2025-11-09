class PrayerTimeHelper {
  // List of prayer names in order
  static const List<String> prayerOrder = [
    'Fajr',
    'Sunrise',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  // Excluded prayer times from notifications
  static const List<String> excludedPrayerTimes = [
    'Sunset',
    'Midnight',
    'Firstthird',
    'Lastthird',
    'Imsak',
  ];

  /// Get the next prayer based on current time
  static Map<String, String>? getNextPrayer(Map<String, dynamic> timings) {
    final now = DateTime.now();

    for (final prayerName in prayerOrder) {
      if (timings.containsKey(prayerName)) {
        final timeString = timings[prayerName].toString().split(' ')[0];
        final prayerDateTime = _parseTime(timeString);

        if (prayerDateTime != null && prayerDateTime.isAfter(now)) {
          return {
            'name': prayerName,
            'time': _formatTime(timeString),
          };
        }
      }
    }

    // If no prayer found today, return Fajr of tomorrow
    if (timings.containsKey('Fajr')) {
      final timeString = timings['Fajr'].toString().split(' ')[0];
      return {
        'name': 'Fajr',
        'time': _formatTime(timeString),
      };
    }

    return null;
  }

  /// Calculate countdown to next prayer
  static String calculateCountdown(String prayerTime) {
    final prayerDateTime = _parseTime(prayerTime);
    if (prayerDateTime == null) return '';

    final now = DateTime.now();
    final difference = prayerDateTime.difference(now);

    if (difference.isNegative) {
      // Prayer time has passed for today, calculate for tomorrow
      final tomorrowPrayer = prayerDateTime.add(const Duration(days: 1));
      final tomorrowDiff = tomorrowPrayer.difference(now);
      return _formatDuration(tomorrowDiff);
    }

    return _formatDuration(difference);
  }

  /// Get current ongoing prayer
  static Map<String, String>? getCurrentPrayer(Map<String, dynamic> timings) {
    final now = DateTime.now();

    for (int i = 0; i < prayerOrder.length; i++) {
      final currentPrayer = prayerOrder[i];
      final nextPrayer = i < prayerOrder.length - 1 ? prayerOrder[i + 1] : null;

      if (timings.containsKey(currentPrayer)) {
        final currentTimeString =
            timings[currentPrayer].toString().split(' ')[0];
        final currentDateTime = _parseTime(currentTimeString);

        if (currentDateTime == null) continue;

        // Check if we're between current and next prayer
        if (nextPrayer != null && timings.containsKey(nextPrayer)) {
          final nextTimeString = timings[nextPrayer].toString().split(' ')[0];
          final nextDateTime = _parseTime(nextTimeString);

          if (nextDateTime != null &&
              now.isAfter(currentDateTime) &&
              now.isBefore(nextDateTime)) {
            return {
              'name': currentPrayer,
              'time': _formatTime(currentTimeString),
            };
          }
        } else if (now.isAfter(currentDateTime)) {
          // Last prayer of the day
          return {
            'name': currentPrayer,
            'time': _formatTime(currentTimeString),
          };
        }
      }
    }

    return null;
  }

  /// Check if prayer should be excluded
  static bool shouldExcludePrayer(String prayerName) {
    return excludedPrayerTimes.contains(prayerName);
  }

  /// Parse time string to DateTime
  static DateTime? _parseTime(String timeString) {
    try {
      final parts = timeString.split(':');
      if (parts.length != 2) return null;

      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  /// Format time to 12-hour format
  static String _formatTime(String timeString) {
    try {
      final parts = timeString.split(':');
      if (parts.length != 2) return timeString;

      int hour = int.parse(parts[0]);
      final minute = parts[1];

      final period = hour >= 12 ? 'PM' : 'AM';
      if (hour > 12) {
        hour -= 12;
      } else if (hour == 0) {
        hour = 12;
      }

      return '$hour:$minute $period';
    } catch (e) {
      return timeString;
    }
  }

  /// Format duration to readable string
  static String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 24) {
      final days = hours ~/ 24;
      final remainingHours = hours.remainder(24);
      if (remainingHours > 0) {
        return '$days day${days > 1 ? 's' : ''} $remainingHours hr${remainingHours > 1 ? 's' : ''}';
      }
      return '$days day${days > 1 ? 's' : ''}';
    } else if (hours > 0) {
      if (minutes > 0) {
        return '$hours hr${hours > 1 ? 's' : ''} $minutes min${minutes > 1 ? 's' : ''}';
      }
      return '$hours hr${hours > 1 ? 's' : ''}';
    } else {
      return '$minutes min${minutes > 1 ? 's' : ''}';
    }
  }

  /// Format time for display (simpler version)
  static String formatDisplayTime(String timeString) {
    return _formatTime(timeString.split(' ')[0]);
  }
}
