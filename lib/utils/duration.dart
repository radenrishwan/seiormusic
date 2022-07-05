class DurationUtils {
  static Duration durationParse(String duration) {
    final parts = duration.split(':');
    Map<String, dynamic> partOnList = {
      'minutes': double.parse(parts[1]).toInt(),
      'seconds': double.parse(parts[2]).toInt().round(),
    };

    return Duration(minutes: partOnList['minutes']!, seconds: partOnList['seconds']!);
  }
}
