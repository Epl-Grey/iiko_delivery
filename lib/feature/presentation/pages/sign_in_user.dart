import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/domain/usecases/sign_in_user.dart';
import 'package:iiko_delivery/locator_service.dart';

class SignInUserPage extends StatefulWidget {
  const SignInUserPage({super.key});

  @override
  State<SignInUserPage> createState() => _SignInUserPage();
}

class _SignInUserPage extends State<SignInUserPage> {
  final SignInUser signInUser = sl<SignInUser>();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  void login(String email, String password) async {
    final failureOrUser =
        await signInUser(UserSignInParams(email: email, password: password));
    failureOrUser.fold(
      (failure) => {print(_mapFailureFromMessage(failure))},
      (user) => {
        Navigator.pop(context),
        Navigator.pushNamed(context, "/orders", arguments: user)
      },
    );
  }

  String _mapFailureFromMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      default:
        return "Unexpected error";
    }
  }

  // Future<void> checkLogin() async {
  //   final failureOrUser =
  //       await signInUser(const UserSignInParams(email: '', password: ''));
  //   failureOrUser.fold(
  //     (failure) => {},
  //     (user) => {
  //       Navigator.pop(context),
  //       Navigator.pushNamed(context, "/orders", arguments: user)
  //     },
  //   );
  // }

  // @override
  // void initState() {
  //   checkLogin();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: AppBar(
          backgroundColor: Color(0xFFFAF7F5),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/autho.png"), fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Авторизация",
                  style: TextStyle(
                    color: Color(0xff403f3e),
                    fontSize: 36,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox.square(
              dimension: 3,
            ),
            const Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Введите вашу\n\почту и пароль',
                  style: TextStyle(
                    color: Color(0xFF403F3E),
                    fontSize: 24,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox.square(
              dimension: 100,
            ),
            TextField(
              controller: controller1,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFFAF7F5),
                hintText: "Почта",
              ),
              style: const TextStyle(
                color: Color(0xFF403F3E),
                fontSize: 16,
              ),
            ),
            const SizedBox.square(
              dimension: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFFAF7F5),
                hintText: "Пароль",
              ),
              controller: controller2,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF403F3E),
              ),
            ),
            const SizedBox.square(
              dimension: 12,
            ),
            const Center(
              child: Column(
                children: [
                  SizedBox.square(
                    dimension: 8,
                  ),
                  Text(
                    "Забыли пароль?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF646362),
                      fontSize: 17,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    login(controller1.text, controller2.text);
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF403F3E)),
                    minimumSize: MaterialStatePropertyAll(Size(350, 60)),
                  ),
                  child: const Text(
                    "Авторизация",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
