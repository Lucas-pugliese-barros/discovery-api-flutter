import 'dart:collection';

class TimeTracker {

  static LinkedHashMap _timeHistory = new LinkedHashMap<String, List<DateTime>>();
  static LinkedHashMap _processingTimes = new LinkedHashMap<String, int>();

  static void recordTime(String tag, String message) {
    DateTime dateTime = DateTime.now();

    print('${tag} ${message}: ${dateTime.toString()}');

    _timeHistory = updateHistory(_timeHistory, tag, dateTime);
    _calculateProcessingTime(_timeHistory, tag);
  }

  static DateTime getCurrentTime(String TAG, String message) {
    DateTime dateTime = DateTime.now();

    print('${TAG} ${message}: ${dateTime.toString()}');

    return dateTime;
  }

  static void processingTime(String tag, DateTime start, DateTime end) {
    print('${tag} PROCESSING TIME: ${end.difference(start).inMilliseconds}');
  }

  static LinkedHashMap updateHistory(LinkedHashMap timeHistory, String tag, DateTime dateTime) {
    return (timeHistory.containsKey(tag)) ? _addTimeForTag(timeHistory, tag, dateTime) : _newTagWithTime(timeHistory, tag, dateTime);
  }

  static LinkedHashMap _addTimeForTag(LinkedHashMap timeHistory, String tag, DateTime dateTime) {

    List<DateTime> dates = timeHistory[tag];
    dates.add(dateTime);
    timeHistory.update(tag, (list) => dates);

    return timeHistory;
  }

  static LinkedHashMap _newTagWithTime(LinkedHashMap timeHistory, String tag, DateTime dateTime) {

    List<DateTime> dates = new List();
    dates.add(dateTime);
    timeHistory.putIfAbsent(tag, () => dates);

    return timeHistory;
  }

  static void _calculateProcessingTime(LinkedHashMap<String, List<DateTime>> timeHistory, String tag) {
    if (timeHistory.containsKey(tag) && timeHistory[tag].length % 2 == 0) {
      List<DateTime> dates = timeHistory[tag];

      DateTime penultimateDate = dates[dates.length - 2];
      DateTime lastDate =  dates[dates.length - 1];
      int processingTime = lastDate.difference(penultimateDate).inMilliseconds;
      print('${tag} PROCESSING TIME: ${processingTime}');

      _processingTimes.putIfAbsent(tag, () => processingTime);
    }
  }
}