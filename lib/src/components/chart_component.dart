import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import '../config/app_theme.dart';

class ChartComponent extends StatelessWidget with Base {
  final tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');

  @override
  Widget build(BuildContext context) {
    // taskProgressC.getTaskProgress();

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KText(
              text: 'Total',
              color: hexToColor('#FFA133'),
              fontSize: 16,
            ),
            SizedBox(
              height: 2,
            ),

            KText(
              text: taskProgressC.total.toString(),
              color: AppTheme.textColor,
              bold: true,
              fontSize: 22,
            ),
            // KText(
            //   text: taskProgressC.taskProgressDashbordHome.value != null
            //       ? taskProgressC.taskProgressDashbordHome.value!.openSupports
            //           .toString()
            //       : '',
            //   bold: true,
            //   fontSize: 18,
            //   //color: Colors.white,
            // ),

            // SizedBox(
            //   height: 3,
            // ),
            KText(
              text: 'Tasks',
              color: hexToColor('#80939D'),
              fontSize: 14,
            ),
          ],
        ),
        SizedBox(
          height: 180,
          // color: Colors.amber,
          child: SfCircularChart(
            margin: EdgeInsets.all(0),

            series: _getDefaultDoughnutSeries(),

            // legend: Legend(
            //     alignment: ChartAlignment.far,
            //     isVisible: true,
            //     overflowMode: LegendItemOverflowMode.scroll),
            tooltipBehavior: tooltip,
          ),
        )
      ],
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        radius: '75%',
        explode: false,
        innerRadius: '70%',
        explodeOffset: '50%',
        dataSource: taskProgressC.chartComponent,

        //     <ChartSampleData>[
        //   ChartSampleData(
        //     x: 'Total',
        //     y: 55,
        //     text: '55%',
        //     pointColor: hexToColor('#007BEC'),
        //   ),
        //   ChartSampleData(
        //     x: 'Completed',
        //     y: 10,
        //     text: '10%',
        //     pointColor: hexToColor('#00D8A0'),
        //   ),
        //   ChartSampleData(
        //     x: 'Not Started',
        //     y: 10,
        //     text: '10%',
        //     pointColor: hexToColor('#86A4B5'),
        //   ),
        //   ChartSampleData(
        //     x: 'Pending',
        //     y: 10,
        //     text: '10%',
        //     pointColor: hexToColor('#FF3C3C'),
        //   ),
        // ],
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelMapper: (ChartSampleData data, _) => data.text,
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,

        // dataLabelSettings:
        //     DataLabelSettings(isVisible: false, color: Colors.white38),
      )
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData({
    this.x,
    this.y,
    this.xValue,
    this.yValue,
    this.secondSeriesYValue,
    this.thirdSeriesYValue,
    this.pointColor,
    this.size,
    this.text,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
