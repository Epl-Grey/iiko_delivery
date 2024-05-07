import 'package:decimal/decimal.dart';

class ItemModel {
  final int id;
  final int orderId;
  final String name;
  final int count;
  final Decimal cost;

  const ItemModel({
    required this.id,
    required this.orderId,
    required this.name,
    required this.count,
    required this.cost,
  });

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      orderId: map['order_id'] as int,
      name: map['name'] as String,
      count: map['count'] as int,
      cost: Decimal.fromJson(map['cost'].toString()),
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
