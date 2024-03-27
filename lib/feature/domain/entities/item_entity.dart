import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable{
  final int id;
  final int orderId;
  final String name;
  final int count;
  final int cost;

  ItemEntity({
    required this.id,
    required this.orderId,
    required this.name,
    required this.count,
    required this.cost,
  });
  
  @override
  get props => [id, orderId, name, count, cost];
}
