import 'package:apps/constants.dart';
import 'package:apps/ui/auth/login/LoginScreen.dart';
import 'package:apps/ui/auth/signUp/SignUpScreen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 40, bottom: 20),
            child: TextButton(
              child: Text(
                'Saltar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              onPressed: () {
                shouldSkipLogin = true;
                // pushAndRemoveUntil(context, StoreSelection(), false);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.only(top: 5, bottom: 5),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
              child: Text(
                'Bienvenido a Urban Eats',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: Text(
                "Ordena cosas cerca de ti en tiempo real",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  child: Text(
                    'Iniciar Sesion',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 20, bottom: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: TextButton(
                  child: Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.only(top: 12, bottom: 12),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
