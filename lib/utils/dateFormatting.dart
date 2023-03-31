import 'package:intl/intl.dart';

class DateFormatUtil {
  String formatDate(DateTime date){
    String prefixLiteral = 'th';
    if(date.day.toString().endsWith('1')){
      prefixLiteral = 'st';
    }else if(date.day.toString().endsWith('2')){
      prefixLiteral = 'nd';
    }else if(date.day.toString().endsWith('3')){
      prefixLiteral = 'rd';
    }
    return DateFormat("d'$prefixLiteral' MMM, y").format(date);
  }
}