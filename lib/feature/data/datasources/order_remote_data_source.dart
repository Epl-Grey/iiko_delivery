import 'package:iiko_delivery/feature/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders(bool isDelivered);
  Future<void> setOrderIsDelivered(int id, bool isDelivered);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {

  final SupabaseClient supabaseClient;

  OrderRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<OrderModel>> getUserOrders(bool isDelivered) async {
    final data = await supabaseClient.from('Orders').select().eq('is_delivered', isDelivered);
    return data.map((order) => OrderModel.fromJson(order)).toList();
  }
  
  @override
  Future<void> setOrderIsDelivered(int id, bool isDelivered) async {
    supabaseClient.from("Orders")
                  .update({'is_delivered': isDelivered})
                  .eq('id', id);
    return;
  }  
}
