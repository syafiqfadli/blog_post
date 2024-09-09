import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/presentations/bloc/delete_post/delete_post_cubit.dart';
import 'package:blog_post/features/posts/presentations/widgets/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableData extends DataTableSource {
  final BuildContext context;
  final List<PostEntity> posts;
  final Function(int postId) onDelete;

  TableData({
    required this.context,
    required this.posts,
    required this.onDelete,
  });

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= posts.length) return null;

    final post = posts[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(post.id.toString())),
        DataCell(Text(post.userId.toString())),
        DataCell(Text(post.title)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.description),
                color: Colors.grey,
                tooltip: 'View',
                onPressed: () => _showPostDialog(context, post),
              ),
              BlocBuilder<DeletePostCubit, DeletePostState>(
                builder: (context, state) {
                  if (state is DeletePostLoading && state.postId == post.id) {
                    return const Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    tooltip: 'Delete',
                    onPressed: () => _showDeleteDialog(context, post),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => posts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  void _showPostDialog(BuildContext context, PostEntity post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: PostDetails(post: post),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, PostEntity post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete post ID ${post.id}?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                onDelete(post.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
