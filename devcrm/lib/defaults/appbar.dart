import 'package:flutter/material.dart';

class AppBarDefault {
  PreferredSizeWidget appBarDefault(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.business_center),
                Text('DevCRM'),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                  child: Text('Home', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/leads'),
                  child: Text('Leads', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/contacts'),
                  child:
                      Text('Contacts', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/accounts'),
                  child:
                      Text('Accounts', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/deals'),
                  child: Text('Deals', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/tasks'),
                  child: Text('Tasks', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/meetings'),
                  child:
                      Text('Meetings', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/calls'),
                  child: Text('Calls', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/analytics'),
                  child:
                      Text('Analytics', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/reports'),
                  child: Text('Reports', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
