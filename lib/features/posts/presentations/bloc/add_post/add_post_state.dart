part of 'add_post_cubit.dart';

sealed class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

final class AddPostInitial extends AddPostState {}

final class AddPostLoading extends AddPostState {}

final class AddPostSuccessful extends AddPostState {}

final class AddPostError extends AddPostState {
  final String message;

  const AddPostError({required this.message});

  @override
  List<Object> get props => [message];
}
