import 'dart:core';

import 'package:intl/intl.dart';
import '../model/date_pair.dart';

class MDateUtils {

  static String getPostImage(String id, String image) {
    //return '${Routes.baseUrl}public/images/posts/$id/$image';
    return '$image';
  }

  static String dateToFormattedDate(String? date, bool showYear, {bool? full}) {
    if(date == null) return '';
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate;
    showYear
        ? formattedDate = DateFormat.yMMMd().format(dateTime)
        : formattedDate = DateFormat.MMMd().format(dateTime);
    if(full != null){
      formattedDate = DateFormat.yMMMMd().format(dateTime);
    }
    return formattedDate;
  }
  static String monthYear(String? date) {
    if(date == null) return '';
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate;
    formattedDate = DateFormat('MMMM yyyy').format(dateTime);
    return formattedDate;
  }
  static String postgresDate(String? date) {
    if(date == null) return '';
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate;
    formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  static String dateToDayOfMonth(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    return DateFormat.d().format(dateTime);
  }

  static String dateToMonth(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat.MMM().format(dateTime);
  }

  static String dateToHourMinute(String? date) {
    if(date == null) return '';
    DateTime dateTime = DateTime.tryParse(date)!.toLocal();
    //print(date);
    //return DateFormat.Hm().format(dateTime);
    return DateFormat('hh:mm aa', 'en-IN').format(dateTime).toUpperCase();
    //return 'here';
  }
  static String dateToHourMinuteTimezone(String? date) {
    DateTime dateTime = DateTime.parse(date!).toLocal();
    final v = DateFormat('HH:mm:ss', 'en-IN').format(dateTime).toUpperCase();
    print(v);
    return v;
    //return 'here';
  }

  static String timeAgo(String? date, {bool numericDates = false}) {
    DateTime dateTime = DateTime.parse(date!).toLocal();
    Duration diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) {
      if(diff.inMinutes == 0){
        return 'Just now';
      }
      return numericDates
          ? '${diff.inMinutes} ${diff.inMinutes > 1 ? 'mins': 'min'}'
          : DateFormat.Hm().format(dateTime);
    }
    if (diff.inHours < 24)
      return numericDates
          ? '${diff.inHours} ${diff.inHours > 1 ? 'hrs': 'hr'}'
          : DateFormat.Hm().format(dateTime);
    if (diff.inDays < 2)
      return numericDates ? '1 day' : 'Yesterday';
    if (diff.inDays < 3)
      return numericDates ? '2 days' : '2 days ago';
    if (diff.inDays < 4)
      return numericDates ? '3 days' : '3 days ago';
    if (diff.inDays < 365) return DateFormat('d MMM').format(dateTime);
    return DateFormat.yMMMd().format(dateTime);
  }

  static DateTime nWeekAgo(int n) => DateTime(now().year, now().month, now().day - (7 * n));
  static DateTime nMonthAgo(int n) => DateTime(now().year, now().month - n);
  static DateTime nYearAgo(int n) => DateTime(now().year - n);

  static DateTime now() => DateTime.now();

  static DatePair today() => DatePair('Today', DateTime(now().year, now().month, now().day, 0), DateTime(now().year, now().month, now().day, 24));
  static DatePair yesterday() => DatePair('Yesterday', DateTime(now().year, now().month, now().day - 1, 0), DateTime(now().year, now().month, now().day - 1 , 24));

  static DatePair thisMonth() => DatePair('This Month', DateTime(now().year, now().month, 0, 0), DateTime(now().year, now().month + 1, 0 , 0));
  static DatePair lastMonth() => DatePair('Last Month', DateTime(now().year, now().month - 2, 0, 0), DateTime(now().year, now().month - 1, 0 , 0));

  static DatePair thisYear() => DatePair('This Year', DateTime(now().year), DateTime(now().year + 1));
  static DatePair lastYear() => DatePair('Last Year', DateTime(now().year - 2), DateTime(now().year - 1));

  static String testFormatDate(DateTime date) => DateFormat("dd-MM-yyyy hh:mm:ss aa  ").format(date);

  static String sqlFormatDate(DateTime date) => DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
}
