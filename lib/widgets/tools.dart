import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(this.name);

  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF413F42),
      appBar: AppBar(
          backgroundColor: Color(0XFF980F5A),
          title: Text(
            'Details of report',
          )),
      body: ListView(
        children: [
          // Image.network(SampleImageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
