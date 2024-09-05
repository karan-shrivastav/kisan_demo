import 'package:intl/intl.dart';

class CurrencyFormatter {
  // Method to format currency as Indian Rupees without decimal places
  String formatCurrency(double amount) {
    // Create a NumberFormat instance with custom pattern
    // This pattern applies thousand separators correctly in most contexts but might not apply lakhs and crores without locale
    final formatter = NumberFormat("#,##,###");

    // Return the formatted money string
    return formatter.format(amount);
  }
}