import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initiator/Controllers/Repo/firebase_auth.dart';
import 'package:initiator/Controllers/Repo/local_db_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future checkLogedIn() async {
    emit(AuthLoading());
    final Map res = await LocalDbRepo().getUser();

    if (res['userId'] != null) {
      emit(AuthUserThere());
    } else {
      emit(AuthUserNotThere());
    }
  }

  Future signUpOrLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final Map res = await FirebaseAuthRepo().signUp(email, password);

    if (res['status'] == 'login_success') {
      emit(AuthLoginSuccess('Login Success'));
    } else if (res['status'] == 'sign_success') {
      emit(AuthLoginSuccess('Account created'));
    } else {
      emit(AuthError(res['data'].toString()));
    }
  }
}
