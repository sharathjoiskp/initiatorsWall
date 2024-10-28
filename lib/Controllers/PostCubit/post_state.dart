part of 'post_cubit.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final Stream<List<Post>> postsStream;

  PostLoaded(this.postsStream);
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}
