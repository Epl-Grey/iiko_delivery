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
                    ? const Color(0xFF78C4A4)
                    : Colors.blueGrey.shade100),
          ]);
      barDataList.add(barData);
    }

    return barDataList;
  }

  Widget getTitles(double value, TitleMeta meta) {
    const styleNumber = TextStyle(
      color: Color(0xFF222222),
      fontSize: 20,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      height: 0,
    );
    const styleDayOfWeek = TextStyle(
      color: Color(0xFF222222),
      fontSize: 16,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      height: 0,
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
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 1:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 2:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 3:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 4:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 5:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 6:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 7:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 8:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 9:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
        break;
      case 10:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 11:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 12:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 13:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 14:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 15:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 16:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 17:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 18:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 19:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 20:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 21:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 22:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 23:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 24:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 25:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 26:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 27:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 28:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 29:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      case 30:
        text = Column(
          children: <Widget>[
            Text('${value.toInt() + 1}', style: styleNumber),
            Text(daysOfWeekList[value.toInt()], style: styleDayOfWeek),
          ],
        );
      default:
        text = const Text('', style: styleNumber);
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
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 36 * widget.length * 1.459, // Ширина графика
                height: 350, // Высота графика
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
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
                              context
                                  .read<DailyOrderCubit>()
                                  .getUserOrdersByDay(
                                      true,
                                      DateTime(
                                          widget.selectedDate.year,
                                          widget.selectedDate.month,
                                          response.spot!.touchedBarGroupIndex +
                                              1,
                                          widget.selectedDate.hour,
                                          widget.selectedDate.minute,
                                          widget.selectedDate.second,
                                          widget.selectedDate.millisecond,
                                          widget.selectedDate.microsecond));
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
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Заказы',
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 28,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
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
