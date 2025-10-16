import 'package:flutter/material.dart';
import 'package:shopix/core/errors/service_locator.dart';
import 'package:shopix/features/splash/presentation/views/splash_view.dart';

void main() {
  getItSetup();
  runApp(const Shopix());
}

class Shopix extends StatelessWidget {
  const Shopix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffFFA113),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
    );
  }
}
