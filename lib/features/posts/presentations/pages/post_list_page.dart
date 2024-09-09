import 'package:blog_post/features/feature_injection.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/presentations/bloc/delete_post/delete_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_all_posts/get_all_posts_bloc.dart';
import 'package:blog_post/features/posts/presentations/bloc/search_post/search_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/widgets/posts_table/posts_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final SearchPostCubit _searchPostCubit = featureInjection<SearchPostCubit>();
  final GetAllPostsBloc _getAllPostsBloc = featureInjection<GetAllPostsBloc>();
  final DeletePostCubit _deletePostCubit = featureInjection<DeletePostCubit>();

  @override
  void initState() {
    super.initState();
    _getAllPostsBloc.add(GetPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _searchPostCubit),
        BlocProvider.value(value: _getAllPostsBloc),
        BlocProvider.value(value: _deletePostCubit),
      ],
      child: BlocListener<GetAllPostsBloc, GetAllPostsState>(
        listener: (context, state) {
          if (state is GetAllPostsLoaded) {
            _searchPostCubit.searchPost("");
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: BlocBuilder<SearchPostCubit, List<PostEntity>>(
                builder: (context, posts) {
                  return PostsTable(posts: posts);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
