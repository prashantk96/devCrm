import 'package:get/get.dart';

class Task {
  final String title;
  final String description;

  Task(this.title, this.description);
}

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(String title, String description) {
    tasks.add(Task(title, description));
  }
}
