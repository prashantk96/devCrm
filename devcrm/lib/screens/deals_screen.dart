import 'package:devcrm/controller/deals_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealsScreen extends StatelessWidget {
  final DealsController dealsController = Get.put(DealsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: dealsController.deals.length,
                itemBuilder: (context, index) {
                  var deal = dealsController.deals[index];
                  return ListTile(
                    title: Text(deal.name),
                    subtitle: Text('\$${deal.amount.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddDealDialog(context);
              },
              child: Text('Add Deal'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDealDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Deal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                dealsController.addDeal(
                    nameController.text, double.parse(amountController.text));
                Get.back();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
