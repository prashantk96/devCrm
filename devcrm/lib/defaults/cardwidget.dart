import 'package:flutter/material.dart';

class CardWidgetBuild {
  Widget buildCard(String title, cardHeight) {
    return Expanded(
      child: SizedBox(
        height: cardHeight,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
