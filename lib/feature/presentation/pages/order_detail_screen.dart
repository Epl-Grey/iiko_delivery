import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_state.dart';
import 'package:iiko_delivery/feature/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/location_cubit/location_state.dart';
import 'package:iiko_delivery/feature/presentation/bloc/set_delivered_cubit/set_delivered_cubit.dart';
import 'package:iiko_delivery/feature/presentation/bloc/set_delivered_cubit/set_delivered_state.dart';
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
    int orderId = order.id;
    print('orderId ${orderId}');
    context.read<ItemCubit>().getOrderItems(order.id);
    context.read<LocationCubit>().getPhoneLocation(order.address);

    BitmapDescriptor address = BitmapDescriptor.defaultMarker;
    BitmapDescriptor home = BitmapDescriptor.defaultMarker;
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/deliveryIcon.png")
        .then((icon) => address = icon);
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/home.png")
        .then((icon) => home = icon);

    void launchGoogleMapsNavigation(double startLat, double startLong,
        double destinationLat, double destinationLong) async {
      // Начальная точка

      String googleMapsUrl =
          'https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLong&destination=$destinationLat,$destinationLong&travelmode=driving';

      // ignore: deprecated_member_use
      if (await canLaunch(googleMapsUrl)) {
        // ignore: deprecated_member_use
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
                            icon: home,
                            position: LatLng(state.position.phone.latitude,
                                state.position.phone.longitude)),
                        Marker(
                            markerId: const MarkerId('order'),
                            icon: address,
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
                          launchGoogleMapsNavigation(
                              state.position.phone.latitude,
                              state.position.phone.longitude,
                              state.position.locations[0].latitude,
                              state.position.locations[0].longitude);
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
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    foregroundColor: const Color(0xFF78C4A4),
                    backgroundColor: const Color(0xFF78C4A4),
                    surfaceTintColor: const Color(0xFF78C4A4),
                  ),
                  onPressed: () => context
                      .read<SetDeliveredCubit>()
                      .setOrderIsDelivered(orderId, true),
                  child: const Text(
                    'Доставлено',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      height: 0.07,
                      letterSpacing: 0.09,
                    ),
                  ),
                ),
              ),
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
            BlocListener<SetDeliveredCubit, SetDeliveredState>(
              listener: (context, state) {
                if (state is SetDeliveredLoaded) {
                  print('orderId $orderId, \n isdelivered true');
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/orders");

                } else if (state is SetDeliveredError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ошибка!'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
