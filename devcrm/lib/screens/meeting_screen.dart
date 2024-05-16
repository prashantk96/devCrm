import 'package:devcrm/controller/meeting_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeetingsScreen extends StatelessWidget {
  final MeetingsController meetingsController = Get.put(MeetingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: meetingsController.meetings.length,
                itemBuilder: (context, index) {
                  var meeting = meetingsController.meetings[index];
                  return ListTile(
                    title: Text(meeting.title),
                    subtitle: Text(meeting.date),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddMeetingDialog(context);
              },
              child: Text('Add Meeting'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMeetingDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Meeting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDateAndTime(context, dateController);
                    },
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                meetingsController.addMeeting(
                    titleController.text, dateController.text);
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

  Future<void> _selectDateAndTime(
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
