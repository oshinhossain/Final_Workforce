import 'package:intl/intl.dart';

String formateNumber({required int value}) {
  return NumberFormat('#,##,###').format(value);
}
