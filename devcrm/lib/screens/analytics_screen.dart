import 'package:devcrm/controller/analytic_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatelessWidget {
  final AnalyticsController analyticsController =
      Get.put(AnalyticsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<AnalyticsController>(
          builder: (controller) => ListView(
            children: [
              Container(
                height: 300,
                child: _buildChart(controller),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(AnalyticsController controller) {
    return charts.BarChart(
      controller.getChartData(),
      animate: true,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
  }
}
