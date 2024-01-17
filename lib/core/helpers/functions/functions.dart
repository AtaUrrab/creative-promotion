import 'package:intl/intl.dart';

String getInitialCharacters(String name) => name.isNotEmpty
    ? name
        .trim()
        .split(RegExp(' +'))
        .map((s) => s[0])
        .take(2)
        .join()
        .toUpperCase()
    : '';

extension Formatter on dynamic {
  String formatter() => NumberFormat.compactCurrency(
        decimalDigits: 0,
        symbol: '',
      ).format(this);
}
