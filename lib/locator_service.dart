import 'package:get_it/get_it.dart';
import 'package:iiko_delivery/core/platform/network_info.dart';
import 'package:iiko_delivery/feature/data/datasources/order_remote_data_source.dart';
import 'package:iiko_delivery/feature/data/repositories/order_repository_impl.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders.dart';
import 'package:iiko_delivery/feature/presentation/bloc/cubit/order_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory<OrderCubit>(() => OrderCubit(sl()));
  // UseCases
  sl.registerLazySingleton<GetUserOrders>(() => GetUserOrders(orderRepository: sl()));
  // Repository
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(Supabase.instance.client),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  // External
  sl.registerLazySingleton<Supabase>(() => Supabase.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
