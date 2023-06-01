import 'package:intl/intl.dart';

class DatetimeUtils {
  final DateFormat dayToYearFormater = DateFormat('dd/MM/yyyy');

  String dayToYearFomart(DateTime date) => dayToYearFormater.format(date);
}
