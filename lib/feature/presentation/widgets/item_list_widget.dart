import 'package:flutter/material.dart';
import 'package:iiko_delivery/feature/domain/entities/item_entity.dart';

class OrderItemsList extends StatefulWidget {
  final ItemEntity itemModel;

  const OrderItemsList({
    super.key,
    required this.itemModel,
  });

  @override
  State<OrderItemsList> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderItemsList> {
  var expand = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
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
                Text(
                  widget.itemModel.name,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.itemModel.count.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.itemModel.cost.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
