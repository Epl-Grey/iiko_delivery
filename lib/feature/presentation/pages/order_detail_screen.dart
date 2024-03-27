import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_state.dart';
import 'package:iiko_delivery/feature/presentation/widgets/item_list_widget.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderEntity;
    context.read<ItemCubit>().getUserOrders(order.id);
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              order.address,
              style: const TextStyle(color: Colors.black, fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  iconSize: 50,
                  onPressed: () {},
                  icon: const Icon(Icons.map_sharp),
                  color: Colors.black,
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: () {},
                  icon: const Icon(Icons.phone_in_talk_rounded),
                  color: Colors.black,
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                  color: Colors.black,
                ),
              ],
            ),
            const Text(
              'Состав заказа',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            BlocBuilder<ItemCubit, ItemState>(
              builder: (context, state) {
                if (state is GetOrderItemsSuccessState) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.items.length,
                      itemBuilder: (ctx, index) =>
                          OrderItemsList(itemModel: state.items[index]));
                } else if (state is GetOrderItemsFailState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
