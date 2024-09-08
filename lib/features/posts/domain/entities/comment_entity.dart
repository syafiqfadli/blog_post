import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  const CommentEntity({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  @override
  List<Object?> get props => [id, postId, name, email, body];
}
