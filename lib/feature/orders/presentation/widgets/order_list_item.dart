import 'package:flutter/material.dart';
import 'package:iiko_delivery/feature/orders/domain/entities/order_entity.dart';

class OrderListItem extends StatefulWidget {
  final OrderEntity orderModel;

  const OrderListItem({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var expand = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/orders/detail", arguments: widget.orderModel);
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
                children: [Text('№ ${widget.orderModel.orderNumber}'),
                Text(widget.orderModel.cost.toString())],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
