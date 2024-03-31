import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticaPage extends StatefulWidget {
  const StatisticaPage({super.key});

  @override
  State<StatisticaPage> createState() => _StatisticaPageState();
}

class _StatisticaPageState extends State<StatisticaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Статистика',
            style: TextStyle(
              color: Color(0xFF191817),
              fontSize: 20,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.exit_to_app_outlined)),
          backgroundColor: const Color(0xFFFAF7F5),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backSallary.png')),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox.square(
                    dimension: 10,
                  ),
                  Image.asset('assets/Wallet.png'),
                  const SizedBox.square(
                    dimension: 10,
                  ),
                  const Text('1912.5',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
