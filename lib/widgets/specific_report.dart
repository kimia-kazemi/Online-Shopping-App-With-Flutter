import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecificReport extends StatelessWidget {
  SpecificReport(this.url);
  String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 180,
                    width: 180,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      '$url',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.error);
                      },
                    )),
                SizedBox(height: 8),
                Text(

                  'INSTANT AGE REWIND CONCEALER',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),

                Text('\$20',
                    style: TextStyle(fontSize: 18, fontFamily: 'avenir')),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('user bought'),
                  SizedBox(height: 5),
                  Text('36'),
                ],
              ),
              Column(
                children: [
                  Text('total bought'),
                  SizedBox(height: 5),
                  Text('208'),
                ],
              ),
              Column(
                children: [
                  Text('total available'),
                  SizedBox(height: 5),
                  Text('1000'),
                ],
              )
            ],
          ),
        )


      ],
    );
  }
}