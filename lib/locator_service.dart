import 'package:get_it/get_it.dart';
import 'package:iiko_delivery/core/platform/network_info.dart';
import 'package:iiko_delivery/feature/orders/data/datasources/item_remote_data_source.dart';
import 'package:iiko_delivery/feature/orders/data/datasources/order_remote_data_source.dart';
import 'package:iiko_delivery/feature/orders/data/repositories/item_repository_impl.dart';
import 'package:iiko_delivery/feature/orders/data/repositories/order_repository_impl.dart';
import 'package:iiko_delivery/feature/orders/domain/repositories/item_repository.dart';
import 'package:iiko_delivery/feature/orders/domain/repositories/order_repository.dart';
import 'package:iiko_delivery/feature/orders/domain/usecases/get_order_items.dart';
import 'package:iiko_delivery/feature/orders/domain/usecases/get_user_orders.dart';
import 'package:iiko_delivery/feature/orders/presentation/bloc/item_cubit/item_cubit.dart';
import 'package:iiko_delivery/feature/orders/presentation/bloc/order_cubit/order_cubit.dart';

import 'package:iiko_delivery/feature/users/data/datasources/user_remote_data_source.dart';
import 'package:iiko_delivery/feature/users/data/repositories/user_repository_impl.dart';
import 'package:iiko_delivery/feature/users/domain/repositories/user_repository.dart';
import 'package:iiko_delivery/feature/users/domain/usecases/sign_in_user.dart';
import 'package:iiko_delivery/feature/users/presentation/bloc/sign_in_cubit.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory<OrderCubit>(() => OrderCubit(sl()));
  sl.registerFactory<SignInUserCubit>(() => SignInUserCubit(signInUser: sl()));
  sl.registerFactory<ItemCubit>(() => ItemCubit(sl()));
  // UseCases
  sl.registerLazySingleton<GetUserOrders>(
      () => GetUserOrders(orderRepository: sl()));
  sl.registerLazySingleton<SignInUser>(() => SignInUser(userRepository: sl()));
  sl.registerLazySingleton<GetOrderItems>(
      () => GetOrderItems(orderRepository: sl()));
  // Repository
  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSources: sl()));
  sl.registerLazySingleton<ItemRepository>(
      () => ItemRepositoryImpl(itemRemoteDataSource: sl()));

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(Supabase.instance.client),
  );

  sl.registerLazySingleton<ItemRemoteDataSource>(
    () => ItemRemoteDataSourceImpl(Supabase.instance.client),
  );

  sl.registerLazySingleton<UserRemoteDataSources>(() =>
      UserRemoteDataSourcesImpl(supabaseClient: Supabase.instance.client));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  // External
  sl.registerLazySingleton<Supabase>(() => Supabase.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
