import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginInit extends StatelessWidget {
  const LoginInit({super.key});

  static const routeName = '/login-init';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                // redir
              },
              child: const Text(
                'ENTRAR',
                style: TextStyle(
                  color: Color.fromRGBO(255, 91, 98, 100),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'PERSONAL APP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            buildButton(name: "CADASTRE-SE", type: 'signup'),
            const SizedBox(height: 10),
            buildButton(name: "CONTINUAR COM GOOGLE", type: 'signin'),
          ],
        ),
      ),
    );
  }

  buildButton({required String name, required String type}) => ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(255, 92, 0, 1.0),
          ),
        ),
        onPressed: () {
          if (type == 'signin') {
          } else {}
        },
        child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
      );
}
