import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initiator/Controllers/Repo/firestore_repo.dart';
import 'package:initiator/Model/post_model.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  Future addPost(Post postData) async {
    FirestoreRepo().addPost(postData: postData);
  }

  void fetchPosts() {
    emit(PostLoading());
    try {
      emit(PostLoaded(FirestoreRepo().fetchData()));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
