import 'package:devcrm/controller/report_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsScreen extends StatelessWidget {
  final ReportsController reportsController = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            itemCount: reportsController.reports.length,
            itemBuilder: (context, index) {
              var report = reportsController.reports[index];
              return ListTile(
                title: Text(report.title),
                subtitle: Text(report.description),
              );
            },
          ),
        ),
      ),
    );
  }
}
