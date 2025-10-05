import 'daily_history.dart';

class HomeData {
  final List<BloodPressurePoint> estimationData;
  final List<BloodPressurePoint> predictionData;

  HomeData({required this.estimationData, required this.predictionData});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    List<BloodPressurePoint> parsePoints(String key) {
      if (json[key] == null) return [];
      return (json[key] as List)
          .map((pointJson) => BloodPressurePoint.fromJson(pointJson as Map<String, dynamic>))
          .toList();
    }

    return HomeData(
      estimationData: parsePoints('estimationData'),
      predictionData: parsePoints('predictionData'),
    );
  }
}