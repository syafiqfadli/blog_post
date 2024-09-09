import 'package:bloc/bloc.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/domain/repositories/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_all_posts_event.dart';
part 'get_all_posts_state.dart';

class GetAllPostsBloc extends Bloc<GetAllPostsEvent, GetAllPostsState> {
  final PostRepo postRepo;

  GetAllPostsBloc({
    required this.postRepo,
  }) : super(GetAllPostsInitial()) {
    on<GetPostsEvent>((event, emit) => _getAllPosts(event, emit));
    on<FilterPostsEvent>((event, emit) => _filterPosts(event, emit));
    on<UpdatePostsEvent>((event, emit) => _updatePosts(event, emit));
  }

  Future<void> _getAllPosts(
    GetPostsEvent event,
    Emitter<GetAllPostsState> emit,
  ) async {
    emit(GetAllPostsLoading());

    final postsEither = await postRepo.getAllPosts();

    postsEither.fold(
      (failure) {
        emit(GetAllPostsError(message: failure.message));
      },
      (posts) {
        emit(GetAllPostsLoaded(posts: posts));
      },
    );
  }

  Future<void> _filterPosts(
    FilterPostsEvent event,
    Emitter<GetAllPostsState> emit,
  ) async {
    if (state is! GetAllPostsLoaded) {
      return;
    }

    final posts = (state as GetAllPostsLoaded).posts;
    final updatedPosts =
        posts.where((post) => post.id != event.postId).toList();

    emit(GetAllPostsLoaded(posts: updatedPosts));
  }

  Future<void> _updatePosts(
    UpdatePostsEvent event,
    Emitter<GetAllPostsState> emit,
  ) async {
    if (state is! GetAllPostsLoaded) {
      return;
    }

    final posts = (state as GetAllPostsLoaded).posts;
    final updatedPosts = [...posts, event.post];

    emit(GetAllPostsLoaded(posts: updatedPosts));
  }
}
