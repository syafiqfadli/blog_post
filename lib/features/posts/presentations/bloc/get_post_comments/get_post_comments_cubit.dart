import 'package:bloc/bloc.dart';
import 'package:blog_post/features/posts/domain/entities/comment_entity.dart';
import 'package:blog_post/features/posts/domain/repositories/post_repo.dart';

class GetPostCommentsCubit extends Cubit<List<CommentEntity>> {
  final PostRepo postRepo;

  GetPostCommentsCubit({required this.postRepo}) : super([]);

  Future<void> getComments(int postId) async {
    final commentsEither = await postRepo.getPostComments(postId);
    final comments = commentsEither.getOrElse(() => []);
    emit(comments);
  }

  void resetComments() {
    emit([]);
  }
}
