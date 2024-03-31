// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:iiko_delivery/feature/data/models/item_model.dart';
import 'package:iiko_delivery/feature/domain/entities/item_entity.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_order_items.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders_by_day.dart';

part 'daily_salary_state.dart';

class DailySalaryCubit extends Cubit<DailySalaryState> {
  final GetUserOrdersByDay getUserOrdersByDay;
  final GetOrderItems getOrderItems;

  DailySalaryCubit({required this.getUserOrdersByDay, required this.getOrderItems})
      : super(DailySalaryInitial());

  getDailySalary() async {
    emit(DailySalaryLoading());

    final today = DateTime.now();

    final ordersResponse = await getUserOrdersByDay(OrdersByDayParams(
        year: today.year,
        month: today.month,
        day: today.day,
        isDelivered: true));
    
    Decimal salary = Decimal.fromInt(0);

    ordersResponse.fold(
      (failure) => emit(DailySalaryFailure(message: failure.toString())),
      (orders) async  {
        List<ItemEntity> items = [];

        for (var order in orders){
          final itemsResponse = await getOrderItems(ItemParams(orderId: int.parse(order.orderNumber)));
          itemsResponse.fold(
            (failure) => emit(DailySalaryFailure(message: failure.toString())),
            (itemsFromResponse) => itemsFromResponse.forEach(items.add)
          );
        }

        if(state is DailySalaryFailure) return;
        
        for(var item in items){
          salary += item.cost;
        }
        emit(DailySalarySuccess(salary: salary));
      }
    );
  }
}
