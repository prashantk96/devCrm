import 'package:devcrm/controller/account_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsScreen extends StatelessWidget {
  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: accountController.accounts.length,
                itemBuilder: (context, index) {
                  var account = accountController.accounts[index];
                  return ListTile(
                    title: Text(account.name),
                    subtitle: Text(account.industry),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddAccountDialog(context);
              },
              child: Text('Add Account'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAccountDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController industryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: industryController,
                decoration: InputDecoration(labelText: 'Industry'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                accountController.addAccount(
                    nameController.text, industryController.text);
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
