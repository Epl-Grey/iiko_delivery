import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

class BarGraphWidget extends StatefulWidget {
  final int length;
  final List heights;
  final double width;
  BarGraphWidget({
    super.key,
    required this.length,
    required this.heights,
    required this.width,
  });

  @override
  State<BarGraphWidget> createState() => _BarGraphWidgetState();
}

class _BarGraphWidgetState extends State<BarGraphWidget> {
  List<BarChartGroupData> createBarChartData(
      int numberOfData, List heights, double width) {
    List<BarChartGroupData> barDataList = [];

    for (int i = 0; i < numberOfData; i++) {
      BarChartGroupData barData = BarChartGroupData(x: i, barRods: [
        BarChartRodData(toY: heights[i], width: width),
      ]);
      barDataList.add(barData);
    }

    return barDataList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 500, // Ширина графика
        height: 10000, // Высота графика
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            titlesData: const FlTitlesData(
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: true)),
                bottomTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: true)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: true))),
            barGroups: createBarChartData(
                widget.length, widget.heights, widget.width),
          ),
        ),
      ),
    );
  }
}

class CreateBarChartGroupData extends StatelessWidget {
  final int numberOfData;
  final List heights;
  final double width;

  CreateBarChartGroupData({
    required this.numberOfData,
    required this.heights,
    required this.width,
  });

  List createBarChartGroupData() {
    List barChartData = [];

    for (int i = 0; i < numberOfData; i++) {
      barChartData.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: heights[i],
            color: Colors.blue,
            width: width,
          ),
        ],
      ));
    }

    return barChartData;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
