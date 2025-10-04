class BloodPressurePoint {
  final DateTime time;
  final int systolic;
  final int diastolic;

  const BloodPressurePoint({
    required this.time,
    required this.systolic,
    required this.diastolic,
  });
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
}