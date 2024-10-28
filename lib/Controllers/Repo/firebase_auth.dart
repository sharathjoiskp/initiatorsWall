import 'package:firebase_auth/firebase_auth.dart';
import 'package:initiator/Controllers/Repo/firestore_repo.dart';
import 'package:initiator/Controllers/Repo/local_db_repo.dart';

class FirebaseAuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final Map<String, dynamic> createUserRes = await FirestoreRepo()
          .addUser(userId: credential.user!.uid, email: email);
      return createUserRes;
    } catch (e) {
      String err = e.toString();
      if (err.contains('firebase_auth/email-already-in-use')) {
        return await login(email, password);
      } else {
        return {
          "status": "failed",
          "data": e.toString(),
        };
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      await LocalDbRepo().addUserId(credential.user!.uid, email);
      return {
        "status": "login_success",
        "data": credential.user,
      };
    } catch (e) {
      String err = e.toString();

      if (err.contains('firebase_auth/invalid-credential')) {
        return {
          "status": "failed",
          "data": 'Worng Password',
        };
      } else {
        return {
          "status": "failed",
          "data": e.toString(),
        };
      }
    }
  }
}
