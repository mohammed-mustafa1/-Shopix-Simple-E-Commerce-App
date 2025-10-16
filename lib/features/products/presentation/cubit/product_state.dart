import 'package:equatable/equatable.dart';
import 'package:shopix/features/products/data/model/product/product.dart';

abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
