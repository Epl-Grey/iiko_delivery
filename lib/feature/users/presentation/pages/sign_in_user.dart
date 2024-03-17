import 'package:flutter/material.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/users/domain/usecases/sign_in_user.dart';
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
  void login(String phone, String password) async {
    final failureOrUser =
        await signInUser(UserSignInParams(email: phone, password: password));
    failureOrUser.fold(
      (failure) => {print( _mapFailureFromMessage(failure))},
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
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Авторизация",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox.square(
              dimension: 22,
            ),
            const SizedBox.square(
              dimension: 100,
            ),
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white10,
                hintText: "телефон",
              ),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            TextField(
              controller: controller2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white10,
                hintText: "пароль",
              ),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox.square(
              dimension: 50,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      login(controller1.text, controller2.text);
                      
                    },
                    child: const Text(
                      "Войти",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 8,
                  ),
                  const Text("Войти с помощью\n почты",
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
