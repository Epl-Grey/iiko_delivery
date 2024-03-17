import 'package:iiko_delivery/feature/orders/domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required super.id,
    required super.orderId,
    required super.name,
    required super.count,
    required super.cost,
  });

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      orderId: map['order_id'] as int,
      name: map['name'] as String,
      count: map['count'] as int,
      cost: map['cost'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'name': name,
      'count': count,
      'cost': cost,
    };
  }

}
