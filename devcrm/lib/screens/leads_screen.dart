import 'package:devcrm/controller/leads_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadsScreen extends StatelessWidget {
  final LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: leadController.leads.length,
                itemBuilder: (context, index) {
                  var lead = leadController.leads[index];
                  return ListTile(
                    title: Text(lead.name),
                    subtitle: Text(lead.email),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddLeadDialog(context);
              },
              child: Text('Add Lead'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddLeadDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Lead'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                leadController.addLead(
                    nameController.text, emailController.text);
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
