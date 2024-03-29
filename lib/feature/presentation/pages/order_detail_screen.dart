import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_state.dart';
import 'package:iiko_delivery/feature/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/location_cubit/location_state.dart';
import 'package:iiko_delivery/feature/presentation/widgets/item_list_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderEntity;

    context.read<ItemCubit>().getOrderItems(order.id);
    context.read<LocationCubit>().getPhoneLocation(order.address);

    BitmapDescriptor source = BitmapDescriptor.defaultMarker;
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/deliveryIcon.png")
        .then((icon) => source = icon);

    void launchGoogleMapsNavigation(double startLat, double startLong, double destinationLat, double destinationLong) async {
      // Начальная точка

      String googleMapsUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLong&destination=$destinationLat,$destinationLong&travelmode=driving';

      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    }

    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 400,
              width: 400,
              child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is GetLocationSuccessState) {
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(state.position.locations[0].latitude,
                              state.position.locations[0].longitude),
                          zoom: 15.5),
                      markers: {
                        Marker(
                            markerId: const MarkerId('phone'),
                            position: LatLng(state.position.phone.latitude,
                                state.position.phone.longitude)),
                        Marker(
                            markerId: const MarkerId('order'),
                            icon: source,
                            position: LatLng(
                                state.position.locations[0].latitude,
                                state.position.locations[0].longitude)),
                      },
                    );
                  } else if (state is GetLocationFailState) {
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
            ),
            Text(
              order.address,
              style: const TextStyle(color: Colors.black, fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is GetLocationSuccessState) {
                      return IconButton(
                        iconSize: 50,
                        onPressed: () {
                          launchGoogleMapsNavigation(state.position.phone.latitude, state.position.phone.longitude, state.position.locations[0].latitude, state.position.locations[0].longitude);
                        },
                        icon: const Icon(Icons.map_sharp),
                        color: Colors.black,
                      );
                    } else if (state is GetLocationFailState) {
                      return Center(
                        child: IconButton(
                          iconSize: 50,
                          onPressed: () {},
                          icon: const Icon(Icons.map_sharp),
                          color: Colors.grey.shade600,
                        ),
                      );
                    } else {
                      return Center(
                        child: IconButton(
                          iconSize: 50,
                          onPressed: () {},
                          icon: const Icon(Icons.map_sharp),
                          color: Colors.grey.shade600,
                        ),
                      );
                    }
                  },
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
