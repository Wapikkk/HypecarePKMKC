class BloodPressurePoint {
  final DateTime time;
  final num systolic;
  final num diastolic;

  const BloodPressurePoint({
    required this.time,
    required this.systolic,
    required this.diastolic,
  });

  factory BloodPressurePoint.fromJson(Map<String, dynamic> json) {
    return BloodPressurePoint(
      time: DateTime.parse(json['time']),
      systolic: json['systolic'],
      diastolic: json['diastolic'],
    );
  }
}

class DailyHistory{
  final DateTime date;
  final List<BloodPressurePoint> estimationData;
  final List<BloodPressurePoint> predictionData;
  final List<String> treatments;

  const DailyHistory({
    required this.date,
    required this.estimationData,
    required this.predictionData,
    required this.treatments,
  });

  factory DailyHistory.fromJson(Map<String, dynamic> json) {
    List<BloodPressurePoint> parsePoints(String key) {
      if (json[key] == null) return [];
      return (json[key] as List)
          .map((pointJson) => BloodPressurePoint.fromJson(pointJson as Map<String, dynamic>))
          .toList();
    }

    return DailyHistory(
      date: DateTime.parse(json['date']),
      estimationData: parsePoints('estimationData'),
      predictionData: parsePoints('predictionData'),
      treatments: List<String>.from(json['treatments']),
    );
  }
}