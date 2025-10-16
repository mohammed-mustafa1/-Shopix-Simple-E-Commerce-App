import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopix/core/errors/failure.dart';
import 'package:shopix/core/services/api_service.dart';
import 'package:shopix/features/products/data/model/product/product.dart';
import 'package:shopix/features/products/data/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ApiService _service = ApiService();
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final response = await _service.get(endPoint: 'products');
      List products = response['products'];
      return Right(products.map((e) => Product.fromJson(e)).toList());
    } on DioException catch (dioException) {
      log('exception in ProductRepoImpl.getProducts: $dioException');
      return Left(ServerFailure.fromDioException(dioException));
    } catch (e, st) {
      log('exception in ProductRepoImpl.getProducts: $e $st');
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
