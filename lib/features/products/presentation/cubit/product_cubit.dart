import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopix/features/products/data/repo/product_repo.dart';
import 'package:shopix/features/products/data/repo/product_repo_impl.dart';
import 'package:shopix/features/products/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  final ProductRepo repo = ProductRepoImpl();

  Future<void> getProducts() async {
    emit(ProductLoading());
    final result = await repo.getProducts();
    result.fold(
      (failure) => emit(ProductError(message: failure.errorMessage)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }
}
