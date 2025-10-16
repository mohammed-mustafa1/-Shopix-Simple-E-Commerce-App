import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopix/features/products/presentation/cubit/product_cubit.dart';
import 'package:shopix/features/products/presentation/widgets/products_view_body.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProductCubit()..getProducts()),
        ],
        child: ProductsBody(),
      ),
    );
  }
}
