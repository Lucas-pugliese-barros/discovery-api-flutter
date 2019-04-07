class TimeTracker {

  static DateTime getCurrentTime(String TAG, String message) {
    DateTime dateTime = DateTime.now();

    print('${TAG} ${message}: ${dateTime.toString()}');

    return dateTime;
  }

  static void processingTime(String tag, DateTime start, DateTime end) {
    print('${tag} PROCESSING TIME: ${end.difference(start).inMilliseconds}');
  }
}