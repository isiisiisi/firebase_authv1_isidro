import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authv1_isidro/components/my_button.dart';
import 'package:firebase_authv1_isidro/screens/auth_page.dart'; // Import AuthPage

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  final List<String> _imagePaths = [
    'lib/assets/images/penguin.png',
    'lib/assets/images/penguin1.png',
    'lib/assets/images/penguin2.png'
  ];

  static GlobalKey<NavigatorState> authNavigatorKey =
      GlobalKey<NavigatorState>();

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      authNavigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Access currentUser here

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: _imagePaths.map((imagePath) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 300,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            carouselController: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _imagePaths.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? const Color(0xFFFFC738)
                        : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Meet our penguins,',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF2B2E38),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            user != null ? user.email! : '',
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF2B2E38),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 90),
          MyButton(
            buttonText: "Logout",
            buttonColor: const Color.fromARGB(255, 218, 218, 218),
            textColor: const Color(0xFF2B2E38),
            borderColor: const Color.fromARGB(255, 218, 218, 218),
            onTap: signUserOut,
          ),
        ],
      ),
    );
  }
}
