// onBoardingScreen.dart
import 'package:apps/constants.dart';
import 'package:apps/ui/auth/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  final List<String> _titlesList = [
    "Añade tu Ubicación",
    "Elige tus productos Favoritos",
    "Entrega rápida"
  ];

  final List<String> _subtitlesList = [
    "Conoce a tus compañeros y encuentra productos fabulosos en unos clicks",
    "Elige de entre las diversas tiendas y productos que la comunidad te ofrece",
    "Recibe tus productos favoritos entregados directamente a tu ubicación",
  ];

  final List<String> _imageList = [
    'assets/images/intro_1.png',
    'assets/images/intro_2.png',
    'assets/images/intro_3.png',
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white, // Asegúrate de definir un color de fondo
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: pageController,
            itemCount: _imageList.length,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return getPage(
                _imageList[index],
                _titlesList[index],
                _subtitlesList[index],
                context,
                (index + 1) == _imageList.length,
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: _imageList.length,
                effect: const ScrollingDotsEffect(
                  spacing: 20,
                  activeDotColor: Colors.green,
                  dotColor: Color(0XFFFBDBD1),
                  dotWidth: 7,
                  dotHeight: 7,
                  fixedCenter: false,
                ),
              ),
            ),
          ),
          if (_currentIndex + 1 == _imageList.length)
            Positioned(
              right: 20,
              bottom: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  backgroundColor: Colors.green,
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.94, 50),
                ),
                child: const Text(
                  "Conoce Urban Eats",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () {
                  setFinishedOnBoarding();
                },
              ),
            )
          else
            Positioned(
              right: 20,
              bottom: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Siguiente",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () {
                  pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
              ),
            ),
          if (_currentIndex > 0)
            Positioned(
              left: 20,
              top: 40,
              child: IconButton(
                icon: const Icon(Icons.chevron_left, size: 40, color: Colors.green),
                onPressed: () {
                  pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget getPage(String image, String title, String subtitle, BuildContext context, bool isLastPage) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0XFFFCEEE9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(400, 180),
                  bottomRight: Radius.elliptical(400, 180),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0XFF333333), fontFamily: 'Poppinsm', fontSize: 20),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0XFF333333),
                fontFamily: 'Poppinsl',
                height: 1.5,
                letterSpacing: 1.2,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Future<void> setFinishedOnBoarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(HAS_FINISHED_ONBOARDING, true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AuthScreen()
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inicio'),
//       ),
//       body: const Center(
//         child: Text('Hello World'),
//       ),
//     );
//   }
// }
