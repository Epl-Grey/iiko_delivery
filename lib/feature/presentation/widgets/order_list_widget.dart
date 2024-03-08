
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_list_cubit/order_list_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_list_cubit/order_list_state.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<OrderListCubit, OrderState>(
      builder: (context, state) {
        List<OrderEntity> orders = [];
        if (state is OrderLoading && state.isFirstFetch) {
          return loadingindicator();
        } else if(state is OrderLoaded) {
          orders = state.ordersList;
        }
        return ListView.separated(itemBuilder: (context, index) {
          const Text('text');
          return null;
        }, separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        }, itemCount: orders.length);
      },
    );
  }

  Widget loadingindicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
