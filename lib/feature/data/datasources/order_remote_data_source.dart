import 'package:beFit_Del/feature/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders({bool? isDelivered});
  Future<void> setOrderIsDelivered(int id, bool isDelivered);
  Future<List<OrderModel>> getUserOrdersByDateRange(
      DateTime start, DateTime end,
      {bool? isDelivered});
  RealtimeChannel listenToUserOrdersChanges(String channel, void Function() callback);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final SupabaseClient supabaseClient;

  OrderRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<OrderModel>> getUserOrders({bool? isDelivered}) async {
    List<Map<String, dynamic>> data;

    if (isDelivered == null) {
      data = await supabaseClient
          .from('Orders')
          .select()
          .order('order_date', ascending: true);
    } else {
      data = await supabaseClient
          .from('Orders')
          .select()
          .eq('is_delivered', isDelivered)
          .order('order_date', ascending: true);
    }

    return data.map((order) => OrderModel.fromJson(order)).toList();
  }

  @override
  RealtimeChannel listenToUserOrdersChanges(
      String channel, void Function() callback) {
    var listen = supabaseClient
        .channel('public:$channel')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: channel,
            callback: (payload) => callback)
        .subscribe();
    print('listen --> $listen');
    return listen;
  }

  @override
  Future<void> setOrderIsDelivered(int id, bool isDelivered) async {
  
    final List<Map<String, dynamic>> data = await supabaseClient
        .from("Orders")
        .update({'is_delivered': isDelivered, 'delivery_date': DateTime.now()})
        .eq('order_number', id)
        .select();
    print('data --> $data');
    return;
  }

  @override
  Future<List<OrderModel>> getUserOrdersByDateRange(
      DateTime start, DateTime end,
      {bool? isDelivered}) async {
    List<Map<String, dynamic>> data;

    if (isDelivered == null) {
      data = await supabaseClient
          .from('Orders')
          .select()
          .gte('order_date', start)
          .lt('order_date', end)
          .order('order_date', ascending: true);
    } else {
      data = await supabaseClient
          .from('Orders')
          .select()
          .gte('order_date', start)
          .lt('order_date', end)
          .eq('is_delivered', isDelivered)
          .order('order_date', ascending: true);
    }

    // print(await supabaseClient.from('Orders')
    //                              .select()
    //                              .gte('order_date', start)
    //                              .lt('order_date', end)
    //                              .eq('is_delivered', true)
    //                              .explain());

    return data.map((order) => OrderModel.fromJson(order)).toList();
  }
}
