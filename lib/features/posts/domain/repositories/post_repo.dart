import 'package:blog_post/core/errors/failures.dart';
import 'package:blog_post/features/posts/domain/entities/comment_entity.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepo {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, PostEntity>> getSinglePost(int postId);
  Future<Either<Failure, List<CommentEntity>>> getPostComments(int postId);
  Future<Either<Failure, PostEntity>> deletePost(int postId);
}
