import 'package:blog_post/features/posts/data/repositories/post_repo_impl.dart';
import 'package:blog_post/features/posts/domain/repositories/post_repo.dart';
import 'package:blog_post/features/posts/presentations/bloc/add_post/add_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/delete_post/delete_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_all_posts/get_all_posts_bloc.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_post_comments/get_post_comments_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/row_changed/row_changed_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/search_post/search_post_cubit.dart';
import 'package:blog_post/features/volume_control/presentation/cubit/choose_color_cubit.dart';
import 'package:blog_post/features/volume_control/presentation/cubit/control_volume_cubit.dart';
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

  featureInjection.registerLazySingleton<AddPostCubit>(
    () => AddPostCubit(
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

  featureInjection.registerLazySingleton<RowChangedCubit>(
    () => RowChangedCubit(),
  );

  featureInjection.registerLazySingleton<ControlVolumeCubit>(
    () => ControlVolumeCubit(),
  );

  featureInjection.registerLazySingleton<ChooseColorCubit>(
    () => ChooseColorCubit(),
  );
}
