import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/common/app_colors.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_list_cubit/order_list_cubit.dart';
import 'package:iiko_delivery/feature/presentation/pages/order_screen.dart';
import 'package:iiko_delivery/locator_service.dart' as di;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  // await Supabase.initialize(
  //   url: 'https://zrbpdgxkeuziwancjnux.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpyYnBkZ3hrZXV6aXdhbmNqbnV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM1OTk3MjksImV4cCI6MjAxOTE3NTcyOX0.LRoNNuBTHVojbObD7VgHdYnQxSa5Sv9gB85nh5XZdak',
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OrderListCubit>(
        create: (context) => di.sl<OrderListCubit>(),
      ),
    ], child: MaterialApp(
      theme: ThemeData.dark().copyWith(
       backgroundColor: AppColors.mainBackground,
       scaffoldBackgroundColor: AppColors.cellBackground,
      ),
      home: const HomePage(),
    ),);
  }
}
