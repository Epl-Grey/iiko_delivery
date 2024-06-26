import 'package:beFit_Del/feature/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.address,
    required super.isDelivered,
    required super.clientPhone,
    required super.clientName,
    required super.orderDate,
    super.deliverdDate,
    required super.neadToCall,
    required super.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      orderNumber: map['order_number'] as String,
      address: map['address'] as String,
      isDelivered: map['is_delivered'] as bool,
      clientPhone: map['client_phone'] as String,
      clientName: map['client_name'] as String,
      orderDate: DateTime.parse(map['order_date'] as String),
      deliverdDate: map['date_delivered'] == null
          ? null
          : DateTime.parse(map['date_delivered'] as String),
      neadToCall: map['nead_to_call'] as bool,
      paymentMethod: map['payment_method'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'address': address,
      'isDelivered': isDelivered,
      'clientPhone': clientPhone,
      'clientName': clientName,
      'orderDate': orderDate.toIso8601String(),
      'deliverdDate': deliverdDate!.toIso8601String(),
      'neadToCall': neadToCall,
      'paymentMethod': paymentMethod,
    };
  }
}
