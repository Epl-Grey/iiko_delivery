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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '№ ${widget.orderModel.orderNumber}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                      const SizedBox.square(
                        dimension: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF78C4A4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: BlocBuilder<OrdersCostCubit, OrdersCostState>(
                          builder: (context, state) {
                            if (state is OrdersCostSuccess) {
                              return Text(
                                "${state.costsForRecent[widget.orderModel.id]!.toStringAsFixed(2)} ₽",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              );
                            } else if (state is OrdersCostFailure) {
                              return Text(state.message);
                            } else {
                              return const Text('Loading...');
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox.square(
                    dimension: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.map_outlined),
                      // Image.asset('assets/Regular.png'),
                      const SizedBox.square(
                        dimension: 7,
                      ),
                      Text(
                        widget.orderModel.address,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Nunito',
                          // fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(
                    dimension: 5,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateFormat("hh:mm")
                          .format(widget.orderModel.orderDate.toLocal()),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
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
