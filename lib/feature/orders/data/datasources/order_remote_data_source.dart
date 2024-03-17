import 'package:iiko_delivery/feature/orders/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {

  final SupabaseClient supabaseClient;

  OrderRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<OrderModel>> getUserOrders() async {
    final data = await supabaseClient.from('Orders').select();
    return data.map((order) => OrderModel.fromJson(order)).toList();
  }
}
