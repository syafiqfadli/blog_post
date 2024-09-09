import 'package:bloc/bloc.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/domain/repositories/post_repo.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_all_posts/get_all_posts_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final PostRepo postRepo;
  final GetAllPostsBloc getAllPostsBloc;

  AddPostCubit({
    required this.postRepo,
    required this.getAllPostsBloc,
  }) : super(AddPostInitial());

  Future<void> addPost(PostEntity post) async {
    emit(AddPostLoading());

    final postsEither = await postRepo.addPost(post);

    postsEither.fold(
      (failure) {
        emit(AddPostError(message: failure.message));
      },
      (newPost) {
        emit(AddPostSuccessful());
        getAllPostsBloc.add(UpdatePostsEvent(post: newPost));
      },
    );
  }
}
