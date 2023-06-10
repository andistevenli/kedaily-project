import 'package:intl/intl.dart';

class MyFormat {
  static final DateFormat formatTanggal =
      DateFormat('EEEE, d MMMM yyyy (HH:mm:ss a)');
  static final NumberFormat formatUang =
      NumberFormat.simpleCurrency(locale: 'id_ID');
}
