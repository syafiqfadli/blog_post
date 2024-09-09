import 'package:bloc/bloc.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_all_posts/get_all_posts_bloc.dart';

class SearchPostCubit extends Cubit<List<PostEntity>> {
  final GetAllPostsBloc getAllPostsBloc;

  SearchPostCubit({required this.getAllPostsBloc}) : super([]);

  void searchPost(String query) {
    if (getAllPostsBloc.state is! GetAllPostsLoaded) {
      return;
    }

    final posts = (getAllPostsBloc.state as GetAllPostsLoaded).posts;

    if (query.isEmpty) {
      emit(posts);
      return;
    }

    final filteredPosts = posts.where((post) {
      final searchId = post.id.toString().contains(query);
      final searchUserId = post.userId.toString().contains(query);
      final searchTitle =
          post.title.toLowerCase().contains(query.toLowerCase());

      return searchId || searchUserId || searchTitle;
    }).toList();

    emit(filteredPosts);
  }
}
