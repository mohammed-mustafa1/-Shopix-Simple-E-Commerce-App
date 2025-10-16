import 'package:equatable/equatable.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_cubit.dart';

abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<Cart> cartItems;

  CartLoaded({required this.cartItems});
  @override
  List<Object?> get props => [];
}

class CartError extends CartState {
  final String errorMessage;

  CartError({required this.errorMessage});
  @override
  List<Object?> get props => [];
}

