import 'package:intl/intl.dart';

// Utility class for formatting dates and times consistently across the app
class DateFormatter {
  // Private constructor to prevent instantiation
  DateFormatter._();

  // Format time to display like "7:10 pm" or "11:30 am"
  // Used in alarm displays and time pickers
  static String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  // Format full date to display like "Fri 21 Mar 2025"
  // Used for detailed date information and date pickers
  static String formatDate(DateTime date) {
    return DateFormat('EEE dd MMM yyyy').format(date);
  }
  
  // Format short date to display like "21 Mar 2025"
  // Used in alarm cards for compact date display
  static String formatShortDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // Format date and time together like "Fri 21 Mar 2025, 7:10 pm"
  // Used for detailed alarm information or logging
  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)}, ${formatTime(dateTime)}';
  }

  // Format time in 24-hour format like "19:10"
  // Alternative format for users who prefer 24-hour time
  static String formatTime24Hour(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  // Format relative date like "Today", "Tomorrow", or "Mon 25 Mar"
  // Used for smart date display based on current date
  static String formatRelativeDate(DateTime date) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime targetDate = DateTime(date.year, date.month, date.day);
    
    final int difference = targetDate.difference(today).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference == -1) {
      return 'Yesterday';
    } else if (difference > 1 && difference <= 6) {
      return DateFormat('EEEE').format(date); // Day name like "Monday"
    } else {
      return formatShortDate(date); // Full date for distant dates
    }
  }

  // Check if a date is today
  static bool isToday(DateTime date) {
    final DateTime now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  // Check if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && 
           date.month == tomorrow.month && 
           date.day == tomorrow.day;
  }
}