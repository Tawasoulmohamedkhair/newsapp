import 'package:timeago/timeago.dart' as timeago;

String formatTimeAgo(String date) {
  return timeago.format(
    DateTime.parse(date).toLocal(),
  );
}