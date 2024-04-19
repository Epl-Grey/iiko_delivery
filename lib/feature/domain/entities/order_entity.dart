import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final int id;
  final String orderNumber;
  final String address;
  final bool isDelivered;
  final String clientPhone;
  final String clientName;
  final DateTime orderDate;
  final bool neadToCall;
  final String paymentMethod;

  const OrderEntity({
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

  @override
  get props => [
        id,
        orderNumber,
        address,
        isDelivered,
        clientPhone,
        clientName,
        orderDate,
        neadToCall,
        paymentMethod,
      ];
}
