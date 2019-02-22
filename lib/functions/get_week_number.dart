// TODO: Probably need to change the math in this function.
/// Gets the number of the current week.
int getWeekNumber() {
  final date = DateTime.now();
  final startOfYear = new DateTime(date.year, 1, 1, 0, 0);
  final firstMonday = startOfYear.weekday;
  final daysInFirstWeek = 8 - firstMonday;
  final diff = date.difference(startOfYear);
  var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil() + 1;
  return weeks;
}
