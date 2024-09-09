import 'package:blog_post/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> parseJson) {
    return PostModel(
      userId: parseJson['userId'] ?? 0,
      id: parseJson['id'] ?? 0,
      title: parseJson['title'] ?? '',
      body: parseJson['body'] ?? '',
    );
  }

  static List<PostModel> fromList(List<dynamic> jsonList) {
    List<PostModel> posts = [];

    for (var post in jsonList) {
      posts.add(PostModel.fromJson(post));
    }

    return posts;
  }
}
