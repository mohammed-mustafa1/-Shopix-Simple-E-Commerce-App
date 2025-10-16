import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopix/core/errors/service_locator.dart';
import 'package:shopix/features/cart/presentation/views/cart_view.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shopix/features/products/presentation/views/products_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> widgets = [ProductsView(), const CartView()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<CartCubit>(),
        child: widgets[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
