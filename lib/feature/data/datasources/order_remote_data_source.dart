import 'package:iiko_delivery/feature/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Future<Supabase> supabaseClient;

  OrderRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<OrderModel>> getUserOrders() async {
  final response = Supabase.instance.client
      .from('Order')
      .select();
      
  return response as Future<List<OrderModel>>;
  }
}
