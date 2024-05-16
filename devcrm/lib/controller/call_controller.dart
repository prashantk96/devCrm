import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Call {
  final String contactName;
  final String dateTime;

  Call(this.contactName, this.dateTime);
}

class CallsController extends GetxController {
  var calls = <Call>[].obs;

  void addCall(String contactName, String dateTime) {
    calls.add(Call(contactName, dateTime));
  }

  Future<void> selectDateAndTime(
      BuildContext context, TextEditingController dateController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        dateController.text = combinedDateTime.toString();
      }
    }
  }
}
