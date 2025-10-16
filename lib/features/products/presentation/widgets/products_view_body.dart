import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopix/core/componantes/main_loading_indecator.dart';
import 'package:shopix/features/products/presentation/cubit/product_cubit.dart';
import 'package:shopix/features/products/presentation/cubit/product_state.dart';
import 'package:shopix/features/products/presentation/views/product_details_view.dart';
import 'package:shopix/features/products/presentation/widgets/product_item.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: MainLoadingIndecator());
          }
          if (state is ProductError) {
            return Center(
              child: Container(
                constraints: BoxConstraints.expand(height: 400),
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    state.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is ProductLoaded) {
            final products = state.products;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 380,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsView(product: products[index]),
                    ),
                  );
                },
                child: ProductItem(product: state.products[index]),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
