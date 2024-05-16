import 'package:devcrm/controller/call_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallsScreen extends StatelessWidget {
  final CallsController callsController = Get.put(CallsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: callsController.calls.length,
                itemBuilder: (context, index) {
                  var call = callsController.calls[index];
                  return ListTile(
                    title: Text(call.contactName),
                    subtitle: Text(call.dateTime),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddCallDialog(context);
              },
              child: Text('Add Call'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCallDialog(BuildContext context) {
    TextEditingController contactNameController = TextEditingController();
    TextEditingController dateTimeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Call'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contactNameController,
                decoration: InputDecoration(labelText: 'Contact Name'),
              ),
              TextField(
                controller: dateTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      callsController.selectDateAndTime(
                          context, dateTimeController);
                    },
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                callsController.addCall(
                    contactNameController.text, dateTimeController.text);
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
