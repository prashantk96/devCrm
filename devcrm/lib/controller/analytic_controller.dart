import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsData {
  final String label;
  final int value;

  AnalyticsData(this.label, this.value);
}

class AnalyticsController extends GetxController {
  var analyticsData = <AnalyticsData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate fetching analytics data from a database or API
    loadAnalyticsData();
  }

  void loadAnalyticsData() {
    // Simulated data
    analyticsData.assignAll([
      AnalyticsData('Sales', 120),
      AnalyticsData('Marketing', 200),
      AnalyticsData('Support', 90),
      AnalyticsData('Development', 150),
      AnalyticsData('HR', 80),
    ]);
  }

  List<charts.Series<AnalyticsData, String>> getChartData() {
    return [
      charts.Series<AnalyticsData, String>(
        id: 'Analytics',
        domainFn: (AnalyticsData data, _) => data.label,
        measureFn: (AnalyticsData data, _) => data.value,
        data: analyticsData,
        labelAccessorFn: (AnalyticsData data, _) => '${data.value}',
      )
    ];
  }
}
