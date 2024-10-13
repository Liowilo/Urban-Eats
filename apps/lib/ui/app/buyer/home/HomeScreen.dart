import 'package:apps/ui/app/buyer/BaseLayout.dart';
import 'package:apps/ui/app/buyer/businesses/BusinessProductsScreen.dart';
import 'package:apps/ui/app/buyer/categories/CategoryProductsScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/app_logo.png', // Asegúrate de tener esta imagen
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 10),
          const Text(
            "Más rápido que tu crush respondiendo tus mensajes",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Barra de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: '¿Qué te gustaría ordenar?',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Carrusel de categorías
            const Text(
              "Categorías",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                aspectRatio: 2.0,
              ),
              items: [
                _buildCategoryItem(
                    'assets/images/add_bank_image.png', 'Comida rápida', context),
                _buildCategoryItem(
                    'assets/images/add_bank_image.png', 'Bebidas', context),
                _buildCategoryItem(
                    'assets/images/add_bank_image.png', 'Postres', context),
                _buildCategoryItem(
                    'assets/images/add_bank_image.png', 'Vegetariana', context),
              ],
            ),

            const SizedBox(height: 20),

            // Grid de Negocios (que incluye restaurantes y negocios)
            const Text(
              "Negocios",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: 4, // Solo mostramos 4 negocios
                itemBuilder: (context, index) {
                  return _buildBusinessItem(
                      'Negocio $index', 'assets/images/add_bank_image.png', context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir un item de categoría
  Widget _buildCategoryItem(
      String imagePath, String categoryName, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(categoryName: categoryName),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            children: <Widget>[
              Image.asset(imagePath, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    categoryName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir un item de negocio (similar para restaurantes y negocios)
  Widget _buildBusinessItem(String name, String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegamos a la nueva pantalla de productos del negocio
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessProductsScreen(businessName: name),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
