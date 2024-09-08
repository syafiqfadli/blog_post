part of 'get_all_posts_bloc.dart';

sealed class GetAllPostsState extends Equatable {
  const GetAllPostsState();

  @override
  List<Object> get props => [];
}

final class GetAllPostsInitial extends GetAllPostsState {}

final class GetAllPostsLoading extends GetAllPostsState {}

final class GetAllPostsLoaded extends GetAllPostsState {
  final List<PostEntity> posts;

  const GetAllPostsLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

final class GetAllPostsError extends GetAllPostsState {
  final String message;

  const GetAllPostsError({required this.message});

  @override
  List<Object> get props => [message];
}
