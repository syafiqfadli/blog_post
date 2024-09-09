part of 'get_all_posts_bloc.dart';

sealed class GetAllPostsEvent extends Equatable {
  const GetAllPostsEvent();

  @override
  List<Object> get props => [];
}

final class GetPostsEvent extends GetAllPostsEvent {}

final class FilterPostsEvent extends GetAllPostsEvent {
  final int postId;

  const FilterPostsEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

final class UpdatePostsEvent extends GetAllPostsEvent {
  final PostEntity post;

  const UpdatePostsEvent({required this.post});

  @override
  List<Object> get props => [post];
}
