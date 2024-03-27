class OrderEntity {
  final int id;
  final String orderNumber;
  final String address;
  final int cost;
  final bool isDelivered;
  final String clientPhone;
  final String clientName;
  final String orderDate;
  
  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.address,
    required this.cost,
    required this.isDelivered,
    required this.clientPhone,
    required this.clientName,
    required this.orderDate,
  });
}
