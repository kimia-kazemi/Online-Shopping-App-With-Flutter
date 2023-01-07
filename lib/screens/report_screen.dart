import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:shoppo/constatnts/kappbar.dart';

import '../widgets/tools.dart';

const String _loremIpsumParagraph =
    ' You need to change detail of the product to this: \n'
    '\n'
    'HOW TO APPLY BRONZER STEP 1: WARM UP THE FACE Apply bronzer onto the cheekbones just above the hollows of the cheeks to warm up the face.\n'
    'HOW TO APPLY BRONZER STEP 2: CONTOUR Sweep remaining color on the brush upward onto the forehead in the shape of a “C” and back down the face in a “3”, ending under your jawline. Result: the perfect tan, minus the sun, and plus contouring in all the right places.';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  List titleName = [
    'Report type: Edit',
    'Report type: Delete',
    'Report type: Fix',
    'Report type: Edit'
  ];

  List subTitle = [
    'Wrong Name lable',
    'Run out of this product',
    'Detail should be fixed',
    'Picture of product should be change'
  ];

  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) => Scaffold(
                appBar: AdminAppBar(context),
                body: ListView.builder(
                    itemCount: titleName.length,
                    itemBuilder: (context, index) {
                      return OpenContainer<bool>(
                        openBuilder: (context, openContainer) =>
                            DetailsPage(_loremIpsumParagraph),
                        tappable: false,
                        closedShape: const RoundedRectangleBorder(),
                        closedElevation: 0,
                        closedBuilder: (context, openContainer) {
                          final item1 = titleName[index];
                          final item2 = subTitle[index];

                          return Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    onTap: openContainer,
                                    title: Text(item1),
                                    subtitle: Text(item2),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        titleName.removeAt(index);
                                        subTitle.removeAt(index);
                                      });
                                    },
                                    icon: Icon(Icons.delete_outline)),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              )),
    );
  }
}
