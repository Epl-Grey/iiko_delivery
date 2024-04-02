import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/presentation/bloc/statistic_cubit/statistic_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/statistic_cubit/statistic_state.dart';
import 'package:iiko_delivery/feature/presentation/widgets/bar_graph_widget.dart';
import 'package:iiko_delivery/feature/presentation/widgets/order_list_item.dart';
import 'package:intl/intl.dart';

class StatisticaPage extends StatefulWidget {
  const StatisticaPage({super.key});

  @override
  State<StatisticaPage> createState() => _StatisticaPageState();
}

class _StatisticaPageState extends State<StatisticaPage> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String month = DateFormat('MM').format(_selectedDate);
    String year = DateFormat('yyyy').format(_selectedDate);
    context
        .read<StatisticCubit>()
        .getUserOrdersByMonth(int.parse(year), int.parse(month), true);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Статистика',
            style: TextStyle(
              color: Color(0xFF191817),
              fontSize: 20,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.exit_to_app_outlined)),
          backgroundColor: const Color(0xFFFAF7F5),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backSallary.png')),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox.square(
                    dimension: 10,
                  ),
                  Image.asset('assets/Wallet.png'),
                  const SizedBox.square(
                    dimension: 10,
                  ),
                  const Text('1912.5',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      )),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: const Text('Выбрать дату'),
            ),
            SizedBox(
              height: 300,
              child: BlocBuilder<StatisticCubit, StatisticState>(
                builder: (context, state) {
                  if (state is GetUserStatisticsSuccessState) {
                    return BarGraphWidget(length: state.orders.length, heights: state.orders,);
                  } else if (state is GetUserStatisticsFailState) {
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
        ));
  }
}
