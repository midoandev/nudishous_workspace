enum ActivityFilter { last7Days, last30Days, currentMonth }

extension ActivityFilterX on ActivityFilter {
  DateTime get startDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return switch (this) {
      ActivityFilter.last7Days => today.subtract(const Duration(days: 6)),
      ActivityFilter.last30Days => today.subtract(const Duration(days: 29)),
      ActivityFilter.currentMonth => DateTime(now.year, now.month, 1),
    };
  }

  DateTime get endDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }
}