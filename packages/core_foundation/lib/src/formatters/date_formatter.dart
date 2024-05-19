import 'package:intl/intl.dart';

/// Helper date formatter methods
class DateFormatter {
  String formatddMMyyyy(DateTime input) {
    return DateFormat("dd/MM/yyyy").format(input.toLocal());
  }
}
