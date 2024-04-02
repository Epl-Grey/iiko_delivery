import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

class BarGraphWidget extends StatefulWidget {
  final int length;
  final List<OrderEntity> heights;
  BarGraphWidget({
    super.key,
    required this.length,
    required this.heights,
  });

  @override
  State<BarGraphWidget> createState() => _BarGraphWidgetState();
}

class _BarGraphWidgetState extends State<BarGraphWidget> {
  List<BarChartGroupData> createBarChartData(
      int numberOfData, List<OrderEntity> heights, double width) {
    List<BarChartGroupData> barDataList = [];

    for (int i = 0; i < heights.length; i++) {
      BarChartGroupData barData = BarChartGroupData(x: i, barRods: [
        BarChartRodData(
          toY: heights[i].cost.toDouble(),
          width: 50,
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueGrey.shade100,
        ),
      ]);
      barDataList.add(barData);
    }

    return barDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        
        child: Container(
          width: 36 * widget.length * 1.56, // Ширина графика
          height: 10000, // Высота графика
          child: BarChart(
            BarChartData(
              
              alignment: BarChartAlignment.spaceAround,
              maxY: 10000,
              titlesData: const FlTitlesData(
                show: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              gridData: const FlGridData(show: false),
              barGroups:
                  createBarChartData(widget.length, widget.heights, 36),
            ),
          ),
        ),
      ),
    );
  }
}
