import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:beFit_Del/feature/domain/entities/order_entity.dart';
import 'package:beFit_Del/feature/presentation/bloc/item_cubit/item_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/item_cubit/item_state.dart';
import 'package:beFit_Del/feature/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/location_cubit/location_state.dart';
import 'package:beFit_Del/feature/presentation/bloc/orders_cost_cubit/orders_cost_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/set_delivered_cubit/set_delivered_cubit.dart';
import 'package:beFit_Del/feature/presentation/bloc/set_delivered_cubit/set_delivered_state.dart';
import 'package:beFit_Del/feature/presentation/widgets/item_list_widget.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderEntity;
    int orderId = order.id;
    bool isDelivered = order.isDelivered;
    context.read<ItemCubit>().getOrderItems(order.id);
    context.read<LocationCubit>().getPhoneLocation(order.address);
    context.read<OrdersCostCubit>().getOrdersCost(isDelivered);

    BitmapDescriptor address = BitmapDescriptor.defaultMarker;
    BitmapDescriptor home = BitmapDescriptor.defaultMarker;
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/deliveryIcon.png")
        .then((icon) => address = icon);
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/home.png")
        .then((icon) => home = icon);

    List<double> locationList = [];

    void launchGoogleMapsNavigation(double startLat, double startLong,
        double destinationLat, double destinationLong) async {
      // Начальная точка

      String googleMapsUrl =
          'geo:$startLat,$startLong?q=$destinationLat,$destinationLong';

      // ignore: deprecated_member_use
      if (await canLaunch(googleMapsUrl)) {
        // ignore: deprecated_member_use
        await launch(googleMapsUrl);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Номер заказа | $orderId",
          style: const TextStyle(
            color: Color(0xFF191817),
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/orders");
            },
            icon: const Icon(Icons.exit_to_app_outlined)),
        backgroundColor: const Color(0xFFFAF7F5),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFFAF7F5),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            child: Container(
              color: const Color(0xFFFAF7F5),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ]),
                    child: SizedBox(
                      height: 250,
                      child: BlocBuilder<LocationCubit, LocationState>(
                        builder: (context, state) {
                          if (state is GetLocationSuccessState) {
                            return GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      state.position.locations[0].latitude,
                                      state.position.locations[0].longitude),
                                  zoom: 15.5),
                              markers: {
                                Marker(
                                    markerId: const MarkerId('phone'),
                                    icon: home,
                                    position: LatLng(
                                        state.position.phone.latitude,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          order.address,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFEFEBE8),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            BlocBuilder<LocationCubit, LocationState>(
                              builder: (context, state) {
                                if (state is GetLocationSuccessState) {
                                  return Column(
                                    children: [
                                      IconButton(
                                        iconSize: 30,
                                        onPressed: () {
                                          launchGoogleMapsNavigation(
                                              state.position.phone.latitude,
                                              state.position.phone.longitude,
                                              state.position.locations[0]
                                                  .latitude,
                                              state.position.locations[0]
                                                  .longitude);
                                        },
                                        icon: const Icon(Icons.map_sharp),
                                        color: Colors.black,
                                      ),
                                      const Text(
                                        'Маршрут',
                                        style: TextStyle(
                                          color: Color(0xFF222222),
                                          fontSize: 14,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                          letterSpacing: 0.14,
                                        ),
                                      )
                                    ],
                                  );
                                } else if (state is GetLocationFailState) {
                                  return Center(
                                    child: IconButton(
                                      iconSize: 30,
                                      onPressed: () {},
                                      icon: const Icon(Icons.map_sharp),
                                      color: Colors.grey.shade600,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: IconButton(
                                      iconSize: 30,
                                      onPressed: () {},
                                      icon: const Icon(Icons.map_sharp),
                                      color: Colors.grey.shade600,
                                    ),
                                  );
                                }
                              },
                            ),
                            const VerticalDivider(),
                            Column(
                              children: [
                                IconButton(
                                  iconSize: 30,
                                  onPressed: () async {
                                    String telephoneNumber = order.clientPhone;
                                    String telephoneUrl =
                                        "tel:$telephoneNumber";
                                    // ignore: deprecated_member_use
                                    if (await canLaunch(telephoneUrl)) {
                                      // ignore: deprecated_member_use
                                      await launch(telephoneUrl);
                                    } else {
                                      throw "Error occured trying to call that number.";
                                    }
                                  },
                                  icon: const Icon(Icons.phone_in_talk_rounded),
                                  color: Colors.black,
                                ),
                                const Text(
                                  'Имя заказчика',
                                  style: TextStyle(
                                    color: Color(0xFF222222),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: 0.14,
                                  ),
                                )
                              ],
                            ),
                            const VerticalDivider(),
                            Column(
                              children: [
                                IconButton(
                                  iconSize: 30,
                                  onPressed: () async {
                                    String telephoneNumber = '+2347012345678';
                                    String telephoneUrl =
                                        "tel:$telephoneNumber";
                                    // ignore: deprecated_member_use
                                    if (await canLaunch(telephoneUrl)) {
                                      // ignore: deprecated_member_use
                                      await launch(telephoneUrl);
                                    } else {
                                      throw "Error occured trying to call that number.";
                                    }
                                  },
                                  icon: const Icon(Icons.phone),
                                  color: Colors.black,
                                ),
                                const Text(
                                  'Оператор',
                                  style: TextStyle(
                                    color: Color(0xFF222222),
                                    fontSize: 14,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: 0.14,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Способ  оплаты',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 18,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F5),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: const Color(0xFFC9C1B9)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        child: GestureDetector(
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox.square(
                                dimension: 10,
                              ),
                              Image.asset('assets/ticket.png'),
                              const SizedBox.square(
                                dimension: 10,
                              ),
                              Text(order.paymentMethod,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Состав заказа',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 18,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<ItemCubit, ItemState>(
                        builder: (context, state) {
                          if (state is GetOrderItemsSuccessState) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.items.length,
                                itemBuilder: (ctx, index) => OrderItemsList(
                                    itemModel: state.items[index]));
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
                  const Divider(color: Color(0xFFAFA8A1)),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Expanded(
                          child: Text(
                            'Итого:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child:
                                BlocBuilder<OrdersCostCubit, OrdersCostState>(
                              builder: (context, state) {
                                if (state is OrdersCostSuccess) {
                                  return Text(
                                    " ${state.costs[orderId]!.toStringAsFixed(2)} ₽",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                } else if (state is OrdersCostFailure) {
                                  return Text(state.message);
                                } else {
                                  return const Text('Loading...');
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Expanded(
                          child: Text(
                            'Выручка(40%):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child:
                                BlocBuilder<OrdersCostCubit, OrdersCostState>(
                              builder: (context, state) {
                                if (state is OrdersCostSuccess) {
                                  return Text(
                                    " ${state.costsForRecent[orderId]!.toStringAsFixed(2)} ₽",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                } else if (state is OrdersCostFailure) {
                                  return Text(state.message);
                                } else {
                                  return const Text('Loading...');
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFFFAF7F5),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Container(
              color: Color(0xFFFAF7F5),
              height: 60,
              child: Column(
                children: <Widget>[
                  isDelivered
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(60),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.black,
                            surfaceTintColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Заказ доставлен',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              height: 0.07,
                              letterSpacing: 0.09,
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomLeft,
                          child: SwipeableButtonView(
                              buttonText: "Доставлен",
                              buttontextstyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                height: 0.07,
                                letterSpacing: 0.09,
                              ),
                              buttonWidget: Container(
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.grey,
                                ),
                              ),
                              activeColor: const Color(0xFF78C4A4),
                              isFinished: isFinished,
                              onWaitingProcess: () {
                                Future.delayed(Duration(seconds: 2), () {
                                  final double radius = 150; // Радиус в метрах
                                  final distance = Geolocator.distanceBetween(
                                      locationList[0],
                                      locationList[1],
                                      locationList[2],
                                      locationList[3]);
                                  if (distance <= radius) {
                                    context
                                        .read<SetDeliveredCubit>()
                                        .setOrderIsDelivered(orderId, true);
                                  } else {
                                    isFinished = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Вы не в радиусе заказа!'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                });
                              },
                              onFinish: () async {}),
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
                  BlocListener<LocationCubit, LocationState>(
                    listener: (context, state) {
                      if (state is GetLocationSuccessState) {
                        locationList.add(state.position.locations[0].latitude);
                        locationList.add(state.position.locations[0].longitude);
                        locationList.add(state.position.phone.latitude);
                        locationList.add(state.position.phone.longitude);
                        print('${locationList[0]}');
                      } else if (state is GetLocationFailState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ошибка загрузка геолокации'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    child: const SizedBox(),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
