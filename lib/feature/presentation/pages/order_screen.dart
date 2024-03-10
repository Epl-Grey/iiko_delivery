import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/presentation/bloc/cubit/order_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/cubit/order_state.dart';
import 'package:iiko_delivery/feature/presentation/widgets/order_list_item.dart';

class HomePage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/orders';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().getUserOrders();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Orders'),
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(top: 10.0, left: 4, right: 4),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            ),
          ),
          alignment: Alignment.topCenter,
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state is GetUserOrdersSuccessState) {
                print(state.orders);
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
          ),
        ),
      ),
    );
  }
}
