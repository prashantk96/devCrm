import 'package:devcrm/screens/accounts_screen.dart';
import 'package:devcrm/screens/analytics_screen.dart';
import 'package:devcrm/screens/call_screen.dart';
import 'package:devcrm/screens/contact_screen.dart';
import 'package:devcrm/screens/deals_screen.dart';
import 'package:devcrm/screens/home_screen.dart';
import 'package:devcrm/screens/leads_screen.dart';
import 'package:devcrm/screens/meeting_screen.dart';
import 'package:devcrm/screens/report_screen.dart';
import 'package:devcrm/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  requestPermission();
  runApp(MyApp());
}

void requestPermission() async {
  await Permission.phone.request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'devcrm',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/leads', page: () => LeadsScreen()),
        GetPage(name: '/contacts', page: () => ContactsScreen()),
        GetPage(name: '/accounts', page: () => AccountsScreen()),
        GetPage(name: '/deals', page: () => DealsScreen()),
        GetPage(name: '/tasks', page: () => TasksScreen()),
        GetPage(name: '/meetings', page: () => MeetingsScreen()),
        GetPage(name: '/calls', page: () => CallsScreen()),
        GetPage(name: '/analytics', page: () => AnalyticsScreen()),
        GetPage(name: '/reports', page: () => ReportsScreen()),
      ],
    );
  }
}
