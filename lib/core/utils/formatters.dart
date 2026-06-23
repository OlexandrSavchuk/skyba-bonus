import 'package:intl/intl.dart';

class Formatters {
  const Formatters._();

  /// Format currency in UAH
  static String currency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'uk_UA',
      symbol: '₴',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format bonus points
  static String bonus(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount.toInt().toString();
    }
    return amount.toStringAsFixed(2);
  }

  /// Format date as dd.MM.yyyy
  static String date(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  /// Format date and time as dd.MM.yyyy HH:mm
  static String dateTime(DateTime date) {
    return DateFormat('dd.MM.yyyy HH:mm').format(date);
  }

  /// Format date as "dd MMMM yyyy" in Ukrainian
  static String dateFull(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'uk').format(date);
  }

  /// Format time as HH:mm
  static String time(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  /// Format phone number: +380 XX XXX XX XX
  static String phone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleaned.length == 13 && cleaned.startsWith('+380')) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 6)} ${cleaned.substring(6, 9)} ${cleaned.substring(9, 11)} ${cleaned.substring(11)}';
    }
    return phone;
  }

  /// Relative date (Сьогодні, Вчора, or date)
  static String relativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Сьогодні';
    } else if (dateOnly == today.subtract(const Duration(days: 1))) {
      return 'Вчора';
    }

    return Formatters.date(date);
  }
}
