import 'package:get/get.dart';

class Account {
  final String name;
  final String industry;

  Account(this.name, this.industry);
}

class AccountController extends GetxController {
  var accounts = <Account>[].obs;

  void addAccount(String name, String industry) {
    accounts.add(Account(name, industry));
  }
}
