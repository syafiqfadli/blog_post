import 'package:bloc/bloc.dart';
import 'package:blog_post/features/posts/domain/repositories/post_repo.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_all_posts/get_all_posts_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  final PostRepo postRepo;
  final GetAllPostsBloc getAllPostsBloc;

  DeletePostCubit({
    required this.postRepo,
    required this.getAllPostsBloc,
  }) : super(DeletePostInitial());

  Future<void> deletePost(int postId) async {
    emit(DeletePostLoading(postId: postId));

    final postsEither = await postRepo.deletePost(postId);

    postsEither.fold(
      (failure) {
        emit(DeletePostError(message: failure.message));
      },
      (_) {
        emit(DeletePostSuccessful());
        getAllPostsBloc.add(FilterPostsEvent(postId: postId));
      },
    );
  }
}
