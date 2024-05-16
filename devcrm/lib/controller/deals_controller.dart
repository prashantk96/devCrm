import 'package:get/get.dart';

class Deal {
  final String name;
  final double amount;

  Deal(this.name, this.amount);
}

class DealsController extends GetxController {
  var deals = <Deal>[].obs;

  void addDeal(String name, double amount) {
    deals.add(Deal(name, amount));
  }
}
