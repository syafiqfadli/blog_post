import 'package:blog_post/features/feature_injection.dart';
import 'package:blog_post/features/posts/domain/entities/comment_entity.dart';
import 'package:blog_post/features/posts/domain/entities/post_entity.dart';
import 'package:blog_post/features/posts/presentations/bloc/get_post_comments/get_post_comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetails extends StatefulWidget {
  final PostEntity post;

  const PostDetails({super.key, required this.post});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final GetPostCommentsCubit _getPostCommentsCubit =
      featureInjection<GetPostCommentsCubit>();

  @override
  void initState() {
    super.initState();
    _getPostCommentsCubit.getComments(widget.post.id);
  }

  @override
  void dispose() {
    super.dispose();
    _getPostCommentsCubit.resetComments();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _getPostCommentsCubit,
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "[${widget.post.id}] ${widget.post.title.toUpperCase()}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Text(
                    widget.post.body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              BlocBuilder<GetPostCommentsCubit, List<CommentEntity>>(
                builder: (context, comments) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Comments (${comments.length})",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(),
                                    const SizedBox(width: 5),
                                    Text(comment.email),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(comment.body),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
