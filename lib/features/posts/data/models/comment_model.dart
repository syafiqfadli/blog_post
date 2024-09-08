import 'package:blog_post/features/posts/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.postId,
    required super.name,
    required super.email,
    required super.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> parseJson) {
    return CommentModel(
      id: parseJson['id'] ?? 0,
      postId: parseJson['postId'] ?? 0,
      name: parseJson['name'] ?? '',
      email: parseJson['email'] ?? '',
      body: (parseJson['body']).toString().replaceAll("\n", " "),
    );
  }

  static List<CommentModel> fromList(List<dynamic> jsonList) {
    List<CommentModel> comments = [];

    for (var comment in jsonList) {
      comments.add(CommentModel.fromJson(comment));
    }

    return comments;
  }
}
