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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.itemModel.name,
                  style: const TextStyle(
                    color: Color(0xFFAFA8A1),
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  widget.itemModel.count.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${widget.itemModel.cost.toStringAsFixed(2)} ₽",
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
