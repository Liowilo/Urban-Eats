import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apps/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String errorMessage = '';
  String successMessage = '';

  Future<void> registerUser() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        errorMessage = "Las contraseñas no coinciden";
      });
      return;
    }

    final url = Uri.parse('$BACKEND_BASE_URL/api/auth/register');
    
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Registro exitoso
        setState(() {
          successMessage = "Usuario registrado con éxito";
          errorMessage = '';
        });
        Navigator.pop(context);  // Regresar a la pantalla de login
      } else {
        // Muestra el error desde la respuesta del backend
        setState(() {
          errorMessage = data["message"] ?? "Error al registrarse";
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = "Ocurrió un error inesperado. Intenta de nuevo.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
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
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
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
            if (successMessage.isNotEmpty) ...[
              Text(successMessage, style: TextStyle(color: Colors.green)),
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
              onPressed: registerUser,
              child: Text(
                'Crear Cuenta',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
