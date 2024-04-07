import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_cubit/order_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_cubit/order_state.dart';
import 'package:iiko_delivery/feature/presentation/widgets/order_list_item.dart';

class BarGraphWidget extends StatefulWidget {
  final DateTime selectedDate;
  final int length;
  final List<Decimal> salary;

  BarGraphWidget({
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
                        DateTime newDate = DateTime(
                            widget.selectedDate.year,
                            widget.selectedDate.month,
                            groupIndex,
                            widget.selectedDate.hour,
                            widget.selectedDate.minute,
                            widget.selectedDate.second,
                            widget.selectedDate.millisecond,
                            widget.selectedDate.microsecond);
                        context.read<OrderCubit>().getUserOrders(true, newDate);
                        return BarTooltipItem(
                            widget.salary[groupIndex].toString(),
                            const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40));
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
                  maxY: 10000,
                  titlesData: const FlTitlesData(
                    show: false,
                  ),
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
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is GetUserOrdersSuccessState) {
                  return ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (ctx, index) =>
                          OrderListItem(orderModel: state.orders[index]));
                } else if (state is GetUserOrdersFailState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
