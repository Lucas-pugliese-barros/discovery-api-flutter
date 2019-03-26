class TimeTracker {

  static DateTime getCurrentTime() {
    return DateTime.now();
  }

  static void processingTime(DateTime start, DateTime end) {
    print( 'ProcessingTime: ${end.difference(start).inMilliseconds}');
  }
}