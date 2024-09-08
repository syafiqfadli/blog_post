import 'package:blog_post/features/posts/data/repositories/post_repo_impl.dart';
import 'package:blog_post/features/posts/domain/repositories/post_repo.dart';
import 'package:blog_post/features/posts/presentations/bloc/delete_post/delete_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_all_posts/get_all_posts_bloc.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_post_comments/get_post_comments_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/search_post/search_post_cubit.dart';
import 'package:get_it/get_it.dart';

final featureInjection = GetIt.instance;

void featureInit() {
  // Repositories
  featureInjection.registerLazySingleton<PostRepo>(
    () => PostRepoImpl(apiDataSource: featureInjection()),
  );

  //Blocs
  featureInjection.registerLazySingleton<GetAllPostsBloc>(
    () => GetAllPostsBloc(postRepo: featureInjection()),
  );

  featureInjection.registerLazySingleton<DeletePostCubit>(
    () => DeletePostCubit(
      postRepo: featureInjection(),
      getAllPostsBloc: featureInjection(),
    ),
  );

  featureInjection.registerLazySingleton<GetPostCommentsCubit>(
    () => GetPostCommentsCubit(postRepo: featureInjection()),
  );

  featureInjection.registerLazySingleton<SearchPostCubit>(
    () => SearchPostCubit(getAllPostsBloc: featureInjection()),
  );
}
