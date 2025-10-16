import 'package:get_it/get_it.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_cubit.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  getIt.registerSingleton<CartCubit>(CartCubit());
  // getIt.registerLazySingleton<CartCubit>(() => CartCubit());
}
