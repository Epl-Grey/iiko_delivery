import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/presentation/bloc/month_salary_cubit/month_salary_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/month_salary_cubit/month_salary_state.dart';
import 'package:iiko_delivery/feature/presentation/bloc/statistic_cubit/statistic_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/statistic_cubit/statistic_state.dart';
import 'package:iiko_delivery/feature/presentation/widgets/bar_graph_widget.dart';

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
    context.read<StatisticCubit>().getMonthSalary(_selectedDate);
    context.read<MonthOrderCubit>().getUserOrdersByMonth(_selectedDate);
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
                  Expanded(
                    child: BlocBuilder<MonthOrderCubit, MonthSalaryState>(
                      builder: (context, state) {
                        if (state is MonthSalarySuccess) {
                          return Text('${state.salary}₽',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ));
                        } else if (state is MonthSalaryFailure) {
                          return Center(
                            child: Text(state.message),
                          );
                        } else {
                          return const Text('Loading...',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ));
                        }
                      },
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: const Text('Выбрать дату'),
            ),
            Expanded(
              child: BlocBuilder<StatisticCubit, StatisticState>(
                builder: (context, state) {
                  if (state is StatisticSuccess) {
                    return BarGraphWidget(
                      selectedDate: _selectedDate,
                      length: state.length,
                      salary: state.salary,
                    );
                  } else if (state is StatisticFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
