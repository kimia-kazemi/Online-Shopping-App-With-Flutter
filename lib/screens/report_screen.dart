import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_charts/flutter_charts.dart';

import 'package:shoppo/constatnts/kappbar.dart';


import '../widgets/specific_report.dart';
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


  Widget dailyChart() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    // Example shows a mix of positive and negative data values.
    chartData = ChartData(
      dataRows: const [
        [2000.0, 1800.0, 2200.0, 2300.0],
        [1100.0, 1000.0, 1200.0, 800.0,]
      ],
      xUserLabels: const ['Foundation', 'Blush', 'Lipstick', 'Mascara', ],
      dataRowsLegends: const [
        '\$User bought',
        '\$Total bought',
      ],
      chartOptions: chartOptions,
    );
    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = VerticalBarChart(
      size: Size(320,300),

      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }


  Widget annualChartt() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        yTransform: log10,
        yInverseTransform: inverseLog10,
      ),
    );
    chartData = ChartData(

      dataRows: const [
        [800.0, 1000.0, 100000.0,15000,190000,180000,188000,100000,100000,100000,100000,],
        [20.0, 100.0, 20.0,700,780,900,800,300,1000,12000,1000,],
      ],
      xUserLabels: const ['Jan', 'Feb', 'Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov',],
      dataRowsLegends: const [
        '2022',
        '2021',
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      size: Size(320,369),

      painter: LineChartPainter(

        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }


  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) => DefaultTabController(
            length: 2,

            child: Scaffold(
                  appBar: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.shopping_bag_outlined), text: "Products"),
                          Tab(icon: Icon(Icons.insert_chart_rounded), text: "Reports")
                        ],
                      ),
                  ),
                  body: TabBarView(
                    children: [
                      ListView.builder(
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
                                 color: Color(0XFF413F42),
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                          children: [
                            SpecificReport('https://m.media-amazon.com/images/I/61WM4U0OW0L._SX522_.jpg'),
                            SizedBox(height: 20),
                            SpecificReport('https://d3t32hsnjxo7q6.cloudfront.net/i/4621032a92cb428ad640c105b944b39c_ra,w158,h184_pa,w158,h184.png'),
                            SizedBox(height: 10),
                            Divider(
                                color: Colors.black38
                            ),
                            SizedBox(height: 20),
                            Text('Daily earn report',style: TextStyle(fontWeight:FontWeight.w900,fontSize: 20),),
                            SizedBox(height: 20),
                            dailyChart(),
                            SizedBox(height: 30),

                            Text('Annual earn report',style: TextStyle(fontWeight:FontWeight.w900,fontSize: 20),),
                            SizedBox(height: 20),

                            annualChartt()


                          ],
                        ),
                      )


                    ],
                  )
                ),
          )),
    );
  }
}
// class SalesData {
//   SalesData(this.year, this.sales);
//   final String year;
//   final double? sales;
// }
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}