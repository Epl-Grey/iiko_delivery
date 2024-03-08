import 'package:flutter/material.dart';
import 'package:iiko_delivery/feature/presentation/widgets/order_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Заказы'),
        centerTitle: true,
      ),
      body: const OrdersList(),
    );
  }
}