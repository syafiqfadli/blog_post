import 'dart:convert';

import 'package:blog_post/core/app/data/datasources/api_datasource.dart';
import 'package:blog_post/core/constants/route_constant.dart';
import 'package:blog_post/core/errors/failures.dart';
import 'package:blog_post/features/posts/data/models/comment_model.dart';
import 'package:blog_post/features/posts/data/models/post_model.dart';
import 'package:blog_post/features/posts/domain/entities/comment_entity.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/domain/repositories/post_repo.dart';
import 'package:dartz/dartz.dart';

class PostRepoImpl implements PostRepo {
  final ApiDataSource apiDataSource;
  Map<String, String> headers = {'Content-Type': 'application/json'};

  PostRepoImpl({required this.apiDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    final url = Uri.parse(RouteConstant.getAllPosts);
    final responseEither = await apiDataSource.get(url, headers: headers);

    return responseEither.fold(
      (failure) => Left(ServerFailure(message: failure.message)),
      (response) => Right(PostModel.fromList(jsonDecode(response.body))),
    );
  }

  @override
  Future<Either<Failure, PostEntity>> getSinglePost(int postId) async {
    final url = Uri.parse(RouteConstant.getPost(postId));
    final responseEither = await apiDataSource.get(url, headers: headers);

    return responseEither.fold(
      (failure) => Left(ServerFailure(message: failure.message)),
      (response) => Right(PostModel.fromJson(jsonDecode(response.body))),
    );
  }

  @override
  Future<Either<Failure, PostEntity>> deletePost(int postId) async {
    final url = Uri.parse(RouteConstant.deletePost(postId));
    final responseEither = await apiDataSource.get(url, headers: headers);

    return responseEither.fold(
      (failure) => Left(ServerFailure(message: failure.message)),
      (response) => Right(PostModel.fromJson(jsonDecode(response.body))),
    );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getPostComments(
    int postId,
  ) async {
    final url = Uri.parse(RouteConstant.getPostComments(postId));
    final responseEither = await apiDataSource.get(url, headers: headers);

    return responseEither.fold(
      (failure) => Left(ServerFailure(message: failure.message)),
      (response) => Right(CommentModel.fromList(jsonDecode(response.body))),
    );
  }
}
