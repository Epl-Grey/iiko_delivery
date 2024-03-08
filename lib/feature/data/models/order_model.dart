import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.address,
    required super.cost,
    required super.isDelivered,
    required super.clientPhone,
    required super.clientName,
    required super.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderNumber: json['order_number'],
      address: json['address'],
      cost: json['cost'],
      isDelivered: json['is_delivered'],
      clientPhone: json['client_phone'],
      clientName: json['client_name'],
      orderDate: json['order_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'address': address,
      'cost': cost,
      'isDelivered': isDelivered,
      'clientPhone': clientPhone,
      'clientName': clientName,
      'orderDate': orderDate,
    };
  }
}
