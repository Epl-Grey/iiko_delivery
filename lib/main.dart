import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:beFit_Del/feature/presentation/bloc/daily_salary_cubit/daily_salary_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/dayily_order_cubit/daily_order_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/item_cubit/item_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/month_salary_cubit/month_salary_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/set_delivered_cubit/set_delivered_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/sign_out_cubit/sign_out_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/statistic_cubit/statistic_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/order_cubit/order_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/orders_cost_cubit/orders_cost_cubit.dart';
import 'package:beFit_Del/feature/presentation/pages/order_detail_screen.dart';
import 'package:beFit_Del/feature/presentation/pages/order_screen.dart';
import 'package:beFit_Del/feature/presentation/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:beFit_Del/feature/presentation/pages/sign_in_user.dart';
import 'package:beFit_Del/feature/presentation/pages/splash_screen_page.dart';
import 'package:beFit_Del/feature/presentation/pages/statistics_screen.dart';

import 'package:beFit_Del/locator_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zrbpdgxkeuziwancjnux.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpyYnBkZ3hrZXV6aXdhbmNqbnV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM1OTk3MjksImV4cCI6MjAxOTE3NTcyOX0.LRoNNuBTHVojbObD7VgHdYnQxSa5Sv9gB85nh5XZdak',
  );
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  init();

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(
          create: (context) => sl<OrderCubit>(),
        ),
        BlocProvider<SignInUserCubit>(
          create: (context) => sl<SignInUserCubit>(),
        ),
        BlocProvider<ItemCubit>(
          create: (context) => sl<ItemCubit>(),
        ),
        BlocProvider<LocationCubit>(
          create: (context) => sl<LocationCubit>(),
        ),
        BlocProvider<DailySalaryCubit>(
          create: (context) => sl<DailySalaryCubit>(),
        ),
        BlocProvider<OrdersCostCubit>(
          create: (context) => sl<OrdersCostCubit>(),
        ),
        BlocProvider<StatisticCubit>(
          create: (context) => sl<StatisticCubit>(),
        ),
        BlocProvider<MonthSalaryCubit>(
          create: (context) => sl<MonthSalaryCubit>(),
        ),
        BlocProvider<DailyOrderCubit>(
          create: (context) => sl<DailyOrderCubit>(),
        ),
        BlocProvider<SetDeliveredCubit>(
          create: (context) => sl<SetDeliveredCubit>(),
        ),
        BlocProvider<SignOutUserCubit>(
          create: (context) => sl<SignOutUserCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Color(0xFF78C4A4)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Color(0xFF78C4A4)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        home: const SplashPage(),
        routes: {
          '/signIn': (context) => const SignInUserPage(),
          '/orders': (context) => const HomePage(),
          '/splash': (context) => const SplashPage(),
          '/orders/detail': (context) => const OrderDetailPage(),
          '/statistics': (context) => const StatisticaPage(),
        },
      ),
    );
  }
}
