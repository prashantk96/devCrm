import 'package:flutter/material.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:devcrm/defaults/cardwidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CardWidgetBuild bc = CardWidgetBuild();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenHeight * 0.1; // Adjust this value as needed

    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                "Home",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      bc.buildCard('Deals Created This Month', cardHeight),
                      bc.buildCard('Revenue This Month', cardHeight),
                      bc.buildCard('Deals Closing This Month', cardHeight),
                      bc.buildCard('Overdue Tasks', cardHeight),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: cardHeight * 5,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(45.0),
                              child: Text(
                                'Last Quarter Performance Overview',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            const Divider(),
                            _buildTableRow('Leads Created', '10'),
                            const Divider(),
                            _buildTableRow('Deals Created', '10'),
                            const Divider(),
                            _buildTableRow('Deals Won', '5'),
                            const Divider(),
                            _buildTableRow('Revenue', '\$30000'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: bc.buildCard(
                              'Anomaly In Leads Creation This Quarter',
                              cardHeight * 3),
                        ),
                        Expanded(
                          flex: 1,
                          child: bc.buildCard(
                              'Leads By Source This Month', cardHeight * 3),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
