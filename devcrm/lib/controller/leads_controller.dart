import 'package:get/get.dart';

class Lead {
  final String name;
  final String email;

  Lead(this.name, this.email);
}

class LeadController extends GetxController {
  var leads = <Lead>[].obs;

  void addLead(String name, String email) {
    leads.add(Lead(name, email));
  }
}
