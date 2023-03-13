class CountDown {
  String timeLeft(DateTime due) {
    String retVal = "";

    Duration timeUntilDue = due.difference(DateTime.now());

    int daysUntil = timeUntilDue.inDays;
    int hoursUntil = timeUntilDue.inHours - (daysUntil * 24);
    int minUntil = timeUntilDue.inMinutes - (daysUntil * 24 * 60) - (hoursUntil * 60);
    int secUntil = timeUntilDue.inSeconds - (minUntil * 60);
    // String s = _secUntil.toString().substring(_secUntil.toString().length - 2);
    // //Fixed Invalid Range Value
    String s = secUntil.toString().length <= 2 ? secUntil.toString() : secUntil.toString().substring(secUntil.toString().length - 2);

    //Check whether to return longDateName date name or not
    if (daysUntil > 0) {
      retVal += "$daysUntil Day Left";
    } else if (hoursUntil > 0) {
      if (hoursUntil <= 9 && minUntil <= 9) {
        retVal += "0${hoursUntil}h:0${minUntil}m Left";
      } else {
        retVal += "${hoursUntil}h:${minUntil}m Left";
      }
    } else if (minUntil > 0) {
      if (minUntil <= 9) {
        retVal += "0$minUntil Min Left";
      } else {
        retVal += "$minUntil Min Left";
      }
    }
    // if (secUntil > 0) {
    //   retVal += s + secondsTextLong;
    // }

    if (secUntil < 1) {
      retVal = "View";
    }
    return retVal;
  }
}
