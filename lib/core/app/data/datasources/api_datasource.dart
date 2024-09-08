import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:blog_post/core/errors/failures.dart';

abstract class ApiDataSource {
  Future<Either<Failure, Response>> get(
    Uri url, {
    Map<String, String>? headers,
  });
  Future<Either<Failure, Response>> post(
    Uri url, {
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });
  Future<Either<Failure, Response>> patch(
    Uri url, {
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });
  Future<Either<Failure, Response>> delete(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });
}

class ApiDataSourceImpl implements ApiDataSource {
  @override
  Future<Either<Failure, Response>> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .get(
            url,
            headers: headers,
          )
          .timeout(const Duration(seconds: 15));

      return Right(response);
    } on TimeoutException catch (error) {
      return Left(ServerFailure(message: error.toString()));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> post(
    Uri url, {
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http
          .post(
            url,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));

      return Right(response);
    } on TimeoutException catch (error) {
      return Left(ServerFailure(message: error.toString()));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> patch(
    Uri url, {
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http
          .patch(
            url,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));

      return Right(response);
    } on TimeoutException catch (error) {
      return Left(ServerFailure(message: error.toString()));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> delete(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http
          .delete(
            url,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));

      return Right(response);
    } on TimeoutException catch (error) {
      return Left(ServerFailure(message: error.toString()));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
