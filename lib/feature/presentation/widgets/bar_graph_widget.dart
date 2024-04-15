import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iiko_delivery/feature/presentation/bloc/dayily_order_cubit/daily_order_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/dayily_order_cubit/daily_order_state.dart';
import 'package:iiko_delivery/feature/presentation/widgets/order_list_item.dart';
import 'package:intl/intl.dart';

class BarGraphWidget extends StatefulWidget {
  final DateTime selectedDate;
  final int length;
  final List<Decimal> salary;

  const BarGraphWidget({
    super.key,
    required this.selectedDate,
    required this.length,
    required this.salary,
  });

  @override
  State<BarGraphWidget> createState() => _BarGraphWidgetState();
}

class _BarGraphWidgetState extends State<BarGraphWidget> {
  late int showingTooltip;
  late DateTime newDate = DateTime(1);
  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  List<BarChartGroupData> createBarChartData(
      int numberOfData, List<Decimal> heights) {
    List<BarChartGroupData> barDataList = [];
    for (int i = 0; i < heights.length; i++) {
      BarChartGroupData barData = BarChartGroupData(
          x: i,
          showingTooltipIndicators: showingTooltip == i ? [0] : [],
          barRods: [
            BarChartRodData(
                toY: heights[i].toDouble(),
                width: 50,
                borderRadius: BorderRadius.circular(5),
                color: showingTooltip == i
                    ? Colors.green
                    : Colors.blueGrey.shade100),
          ]);
      barDataList.add(barData);
    }

    return barDataList;
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    List<String> daysOfWeekList = [];
    Widget text;
    for (int i = 0;
        i <
            DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, 0)
                .day;
        i++) {
      DateTime currentDate =
          DateTime(widget.selectedDate.year, widget.selectedDate.month, i + 1);
      String dayOfWeek = DateFormat('EEEE').format(currentDate);
      if (dayOfWeek == 'Monday') {
        dayOfWeek = 'Пн';
      } else if (dayOfWeek == 'Tuesday') {
        dayOfWeek = 'Вт';
      } else if (dayOfWeek == 'Wednesday') {
        dayOfWeek = 'Ср';
      } else if (dayOfWeek == 'Thursday') {
        dayOfWeek = 'Чт';
      } else if (dayOfWeek == 'Friday') {
        dayOfWeek = 'Пт';
      } else if (dayOfWeek == 'Saturday') {
        dayOfWeek = 'Сб';
      } else if (dayOfWeek == 'Sunday') {
        dayOfWeek = 'Вс';
      }

      daysOfWeekList.add(dayOfWeek);
    }
    switch (value.toInt()) {
      case 0:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 1:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 2:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 3:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 4:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 5:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 6:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 7:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 8:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 9:
        text = Text(
            '  ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 10:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 11:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 12:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 13:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 14:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 15:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 16:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 17:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 18:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 19:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 20:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 21:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 22:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 23:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 24:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 25:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 26:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 27:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 28:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 29:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      case 30:
        text = Text(' ${value.toInt() + 1} \n ${daysOfWeekList[value.toInt()]}',
            style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 36 * widget.length * 1.56, // Ширина графика
              height: 400, // Высота графика
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        context.read<DailyOrderCubit>().getUserOrdersByDay(
                            true,
                            DateTime(
                                widget.selectedDate.year,
                                widget.selectedDate.month,
                                groupIndex + 1,
                                widget.selectedDate.hour,
                                widget.selectedDate.minute,
                                widget.selectedDate.second,
                                widget.selectedDate.millisecond,
                                widget.selectedDate.microsecond));
                        return BarTooltipItem(
                            '${widget.salary[groupIndex].toString()}₽',
                            const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20));
                      },
                      getTooltipColor: (group) => Colors.white,
                    ),
                    touchCallback: (event, response) {
                      if (response != null &&
                          response.spot != null &&
                          event is FlTapUpEvent) {
                        setState(() {
                          final x = response.spot!.touchedBarGroup.x;
                          final isShowing = showingTooltip == x;
                          if (isShowing) {
                            showingTooltip = -1;
                          } else {
                            showingTooltip = x;
                          }
                        });
                      }
                    },
                  ),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 5000,
                  titlesData: FlTitlesData(
                      show: true,
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getTitles,
                        reservedSize: 68,
                      ))),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: const FlGridData(show: false),
                  barGroups: createBarChartData(widget.length, widget.salary),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<DailyOrderCubit, DailyOrderState>(
              builder: (context, state) {
                if (state is GetUserDailyOrdersSuccessState) {
                  return ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (ctx, index) =>
                          OrderListItem(orderModel: state.orders[index]));
                } else if (state is GetUserDailyOrdersFailState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
