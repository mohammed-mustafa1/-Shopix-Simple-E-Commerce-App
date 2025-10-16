import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_state.dart';
import 'package:shopix/features/products/data/model/product/product.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    getCart();
  }

  List<Cart> cartItems = [];

  void getCart() async {
    emit(CartLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(CartLoaded(cartItems: cartItems));
  }

  void decrementQuantity({required Product product}) {
    emit(CartLoading());
    final index = cartItems.indexWhere(
      (element) => element.product.id == product.id,
    );
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      emit(CartError(errorMessage: 'quantity cannot be negative'));
    }

    emit(CartLoaded(cartItems: cartItems));
  }

  void removeFromCart({required Product product}) {
    emit(CartLoading());
    Future.delayed(const Duration(seconds: 1));
    cartItems.removeWhere((element) => element.product.id == product.id);
    emit(CartLoaded(cartItems: cartItems));
  }

  void addToCartOrIncrementQuantity({required Product product}) {
    emit(CartLoading());
    final index = cartItems.indexWhere(
      (element) => element.product.id == product.id,
    );
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(Cart(product: product, quantity: 1));
    }

    emit(CartLoaded(cartItems: cartItems));
  }
}

class Cart {
  final Product product;
  int quantity;

  Cart({required this.product, required this.quantity});
}
