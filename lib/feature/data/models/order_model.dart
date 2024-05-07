import 'package:beFit_Del/feature/domain/entities/order_entity.dart';

class OrderModel {
  final int id;
  final String orderNumber;
  final String address;
  final bool isDelivered;
  final String clientPhone;
  final String clientName;
  final DateTime orderDate;
  final bool neadToCall;
  final String paymentMethod;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.address,
    required this.isDelivered,
    required this.clientPhone,
    required this.clientName,
    required this.orderDate,
    required this.neadToCall,
    required this.paymentMethod,
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
      neadToCall: map['nead_to_call'] as bool,
      paymentMethod: map['payment_method'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderNumber': orderNumber,
        'address': address,
        'isDelivered': isDelivered,
        'clientPhone': clientPhone,
        'clientName': clientName,
        'orderDate': orderDate.toIso8601String(),
        'neadToCall': neadToCall,
        'paymentMethod': paymentMethod,
      };

  OrderEntity toEntity() => OrderEntity(
        id: id,
        orderNumber: orderNumber,
        address: address,
        isDelivered: isDelivered,
        clientPhone: clientPhone,
        clientName: clientName,
        orderDate: orderDate,
        neadToCall: neadToCall,
        paymentMethod: paymentMethod,
        items: const [],
      );
}
