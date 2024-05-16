import 'package:get/get.dart';

class Report {
  final String title;
  final String description;

  Report(this.title, this.description);
}

class ReportsController extends GetxController {
  var reports = <Report>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate fetching reports data from a database or API
    loadReports();
  }

  void loadReports() {
    // Simulated data
    reports.assignAll([
      Report('Monthly Sales Report',
          'This report contains details of monthly sales.'),
      Report('Customer Satisfaction Report',
          'This report analyzes customer satisfaction metrics.'),
      Report('Financial Summary Report',
          'This report provides a summary of financial performance.'),
      Report('Marketing Campaign Report',
          'This report evaluates the effectiveness of marketing campaigns.'),
    ]);
  }
}
