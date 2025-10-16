import 'package:dartz/dartz.dart';
import 'package:shopix/core/errors/failure.dart';
import 'package:shopix/features/products/data/model/product/product.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> getProducts();
}
