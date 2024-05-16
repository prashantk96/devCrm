import 'package:get/get.dart';

class Meeting {
  final String title;
  final String date;

  Meeting(this.title, this.date);
}

class MeetingsController extends GetxController {
  var meetings = <Meeting>[].obs;

  void addMeeting(String title, String date) {
    meetings.add(Meeting(title, date));
  }
}
