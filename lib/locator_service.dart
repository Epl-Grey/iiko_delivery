import 'package:get_it/get_it.dart';
import 'package:iiko_delivery/core/platform/network_info.dart';
import 'package:iiko_delivery/feature/data/datasources/order_remote_data_source.dart';
import 'package:iiko_delivery/feature/data/repositories/order_repository_impl.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_list_cubit/order_list_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

const url = 'https://zrbpdgxkeuziwancjnux.supabase.co';
const key = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpyYnBkZ3hrZXV6aXdhbmNqbnV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM1OTk3MjksImV4cCI6MjAxOTE3NTcyOX0.LRoNNuBTHVojbObD7VgHdYnQxSa5Sv9gB85nh5XZdak';

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory(
    () => OrderListCubit(getUserOrders: sl()),
  );

  // UseCases
  sl.registerLazySingleton(
    () => GetUserOrders(orderRepository: sl()),
  );

  // Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(supabaseClient: Supabase.initialize(url: url, anonKey: key)),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  // External
  sl.registerLazySingleton(() => Supabase.initialize(url: url, anonKey: key));
  sl.registerLazySingleton(() => InternetConnectionChecker());

}
