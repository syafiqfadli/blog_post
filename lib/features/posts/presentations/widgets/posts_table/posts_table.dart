import 'package:blog_post/features/feature_injection.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/presentations/bloc/delete_post/delete_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/row_changed/row_changed_cubit.dart';
import 'package:blog_post/features/posts/presentations/bloc/search_post/search_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/widgets/new_post.dart';
import 'package:blog_post/features/posts/presentations/widgets/posts_table/table_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsTable extends StatefulWidget {
  final List<PostEntity> posts;

  const PostsTable({super.key, required this.posts});

  @override
  State<PostsTable> createState() => _PostsTableState();
}

class _PostsTableState extends State<PostsTable> {
  final TextEditingController _searchController = TextEditingController();
  final RowChangedCubit _rowChangedCubit = featureInjection<RowChangedCubit>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: _rowChangedCubit,
      child: BlocListener<DeletePostCubit, DeletePostState>(
        listener: (context, state) {
          if (state is DeletePostSuccessful) {
            _searchController.clear();
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BlocBuilder<RowChangedCubit, int>(
              builder: (context, row) {
                return PaginatedDataTable(
                  header: Row(
                    children: [
                      const Text('Blog Posts'),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () => _showNewPostDialog(context),
                        tooltip: 'Add Post',
                        icon: const Icon(Icons.add_box_rounded),
                      )
                    ],
                  ),
                  actions: [
                    Container(
                      width: screenWidth < 400 ? screenWidth * 0.3 : 300,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search post...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                _searchPost(_searchController.text),
                            icon: const Icon(Icons.search),
                          ),
                        ),
                        onChanged: _searchPost,
                      ),
                    ),
                  ],
                  rowsPerPage: row,
                  availableRowsPerPage: const [5, 15, 25, 35],
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Actions')),
                  ],
                  source: TableData(
                    context: context,
                    posts: widget.posts,
                    onDelete: (postId) => _onDeletePost(postId),
                  ),
                  onRowsPerPageChanged: (value) {
                    _rowChangedCubit.setRow(value ?? 15);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onDeletePost(int postId) {
    context.read<DeletePostCubit>().deletePost(postId);
  }

  void _searchPost(String value) {
    context.read<SearchPostCubit>().searchPost(value);
  }

  void _showNewPostDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: NewPost(),
        );
      },
    );
  }
}
