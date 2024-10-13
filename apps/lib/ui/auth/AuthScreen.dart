import 'package:apps/constants.dart';
import 'package:apps/ui/auth/login/LoginScreen.dart';
import 'package:apps/ui/auth/signUp/SignUpScreen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);  // Ahora tenemos 3 pestañas
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              // Bienvenida
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
                child: Text(
                  'Bienvenido a Urban Eats',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              // TabBar para seleccionar el rol
              TabBar(
                controller: _tabController,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
                tabs: [
                  Tab(text: 'Comprador'),
                  Tab(text: 'Vendedor'),
                  Tab(text: 'Repartidor'),  // Tercer tab para Repartidor
                ],
              ),
              // Contenido del TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Pantalla para Comprador
                    _buildAuthOptions(context, 'Comprador'),
                    // Pantalla para Vendedor
                    _buildAuthOptions(context, 'Vendedor'),
                    // Pantalla para Repartidor
                    _buildAuthOptions(context, 'Repartidor'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Método para construir las opciones de inicio de sesión y registro para cada rol
  Widget _buildAuthOptions(BuildContext context, String role) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 36),
          child: Text(
            "Estas por entrar a Urban Eats como $role.",
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
                // Aquí pasamos el rol dinámicamente
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(role: role)),  // Enviar el rol recibido
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen(role: role)),
                );
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
        ),
      ],
    );
  }

}
