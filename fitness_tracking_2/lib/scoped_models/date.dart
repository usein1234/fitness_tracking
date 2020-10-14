import 'package:intl/intl.dart';

DateTime labelDate = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(labelDate);
