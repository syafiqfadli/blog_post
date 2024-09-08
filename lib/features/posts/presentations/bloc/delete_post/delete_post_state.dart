part of 'delete_post_cubit.dart';

sealed class DeletePostState extends Equatable {
  const DeletePostState();

  @override
  List<Object> get props => [];
}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostLoading extends DeletePostState {
  final int postId;

  const DeletePostLoading({required this.postId});

  @override
  List<Object> get props => [postId];
}

final class DeletePostSuccessful extends DeletePostState {}

final class DeletePostError extends DeletePostState {
  final String message;

  const DeletePostError({required this.message});

  @override
  List<Object> get props => [message];
}
