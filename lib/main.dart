import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_cubit/order_cubit.dart';
import 'package:iiko_delivery/feature/presentation/pages/order_detail_screen.dart';
import 'package:iiko_delivery/feature/presentation/pages/order_screen.dart';
import 'package:iiko_delivery/feature/presentation/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:iiko_delivery/feature/presentation/pages/sign_in_user.dart';
import 'package:iiko_delivery/feature/presentation/pages/splash_screen_page.dart';

import 'package:iiko_delivery/locator_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zrbpdgxkeuziwancjnux.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpyYnBkZ3hrZXV6aXdhbmNqbnV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM1OTk3MjksImV4cCI6MjAxOTE3NTcyOX0.LRoNNuBTHVojbObD7VgHdYnQxSa5Sv9gB85nh5XZdak',
  );
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
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
        },
      ),
    );
  }
}
