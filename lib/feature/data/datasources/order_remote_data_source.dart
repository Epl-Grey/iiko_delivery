import 'package:iiko_delivery/feature/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders(bool isDelivered);
  Future<void> setOrderIsDelivered(int id, bool isDelivered);
  Future<List<OrderModel>> getUserOrdersByDateRange(DateTime start, DateTime end, {bool? isDelivered});
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
  
  @override
  Future<List<OrderModel>> getUserOrdersByDateRange(DateTime start, DateTime end, {bool? isDelivered}) async {
    List<Map<String, dynamic>> data;
    
    if(isDelivered == null){
      data = await supabaseClient.from('Orders')
                                 .select()
                                 .gte('order_date', start)
                                 .lt('order_date', end);
    }else{
      data = await supabaseClient.from('Orders')
                                 .select()
                                 .gte('order_date', start)
                                 .lt('order_date', end)
                                 .eq('is_delivered', isDelivered);
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
