import 'package:iiko_delivery/feature/data/models/item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ItemRemoteDataSource {
  Future<List<ItemModel>> getOrderItems(int orderId);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {

  final SupabaseClient supabaseClient;

  ItemRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<ItemModel>> getOrderItems(int orderId) async {
    final data = await supabaseClient.from('Items').select().eq('order_id', orderId);
    return data.map((item) => ItemModel.fromJson(item)).toList();
  }
}
