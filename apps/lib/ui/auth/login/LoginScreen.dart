import 'package:apps/services/mobileNetworkConfig.dart';
import 'package:apps/ui/app/products/ProductGridScreen.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apps/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  // Instancia de CookieJar para manejar cookies
  final cookieJar = CookieJar();

  Future<void> loginUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    const urlPath = '$BACKEND_BASE_URL/api/auth/login';
    final url = Uri.parse(urlPath);

    try {
      print("Sending request");
      var navigator = Navigator.of(context);
      final client = getClient();
      final response = await client.post(
        urlPath,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: jsonEncode({"email": email, "password": password}),
      );

      print("Received response");
      print(response.statusCode);
      // Si el servidor responde correctamente
      if (response.statusCode == 200) {
        // Obtener las cookies del servidor
        SharedPreferences sp = await SharedPreferences.getInstance();
        final cookies = sp.getString("cookie");
        if (cookies != null) {
          cookieJar.saveFromResponse(url, [Cookie.fromSetCookieValue(cookies)]);

          // Navegar a la pantalla de productos
          navigator.push(
            MaterialPageRoute(builder: (context) => ProductGridScreen()),
          );
        } else {
          print("Error al obtener token de la cookie");
          setState(() {
            errorMessage = "Error: No se pudo obtener el token de la cookie.";
          });
        }
      } else {
        // Muestra el error desde la respuesta del backend
        setState(() {
          errorMessage = response.data["message"] ?? "Error al iniciar sesión";
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = "Ocurrió un error inesperado. Intenta de nuevo.";
      });
    }
  }

  // Función para extraer el token de la cookie
  String extractTokenFromCookies(String cookies) {
    final tokenCookie = cookies.split(';').firstWhere((cookie) => cookie.contains('token='));
    return tokenCookie.split('=')[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (errorMessage.isNotEmpty) ...[
              Text(errorMessage, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
            ],
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: loginUser,
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}