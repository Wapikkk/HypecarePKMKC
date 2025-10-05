class BloodPressurePoint {
  final int systolic;
  final int diastolic;
  final String time;

  BloodPressurePoint({required this.systolic, required this.diastolic, required this.time});

  factory BloodPressurePoint.fromJson(Map<String, dynamic> json) {
    return BloodPressurePoint(
      systolic: json['systolic'] as int,
      diastolic: json['diastolic'] as int,
      time: json['time'] as String,
    );
  }
}

class HistoryData {
  final List<BloodPressurePoint> estimasiTekananDarah;
  final List<BloodPressurePoint> prediksiTekananDarah;

  HistoryData({required this.estimasiTekananDarah, required this.prediksiTekananDarah});

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    List<BloodPressurePoint> parsePoints(String key) {
      if (json[key] == null) return [];
      return (json[key] as List)
          .map((e) => BloodPressurePoint.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    
    return HistoryData(
      estimasiTekananDarah: parsePoints('estimasiTekananDarah'),
      prediksiTekananDarah: parsePoints('prediksiTekananDarah'),
    );
  }
}