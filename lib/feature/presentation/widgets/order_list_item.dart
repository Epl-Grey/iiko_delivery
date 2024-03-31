import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/presentation/bloc/orders_cost_cubit/orders_cost_cubit.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatefulWidget {
  final OrderEntity orderModel;

  const OrderListItem({
    super.key,
    required this.orderModel,
  });

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var expand = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/orders/detail",
            arguments: widget.orderModel);
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInCubic,
        reverseDuration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 1, color: Colors.grey),
            // boxShadow: const [BoxShadow(offset: Offset(2,2),)]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('№ ${widget.orderModel.orderNumber}'),
                  Text(DateFormat("dd MMMM yyyy hh:mm").format(widget.orderModel.orderDate.toLocal())),
                  BlocBuilder<OrdersCostCubit, OrdersCostState>(
                    builder: (context, state) {
                      if(state is OrdersCostSuccess){
                        return Text(state.costs[widget.orderModel.id]!.toStringAsFixed(2));
                      }else if(state is OrdersCostFailure){
                        return Text(state.message);
                      }else{
                        return const Text('Loading...');
                      }
                    },
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
