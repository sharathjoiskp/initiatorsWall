import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:initiator/Controllers/Repo/local_db_repo.dart';
import 'package:initiator/Model/post_model.dart';

class FirestoreRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addUser(
      {required String userId, required String email}) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'userId': userId,
        'email': email,
      });

      await LocalDbRepo().addUserId(userId, email);
      return {
        "status": "sign_success",
        "data": "User added successfully",
      };
    } catch (e) {
      return {
        "status": "failed",
        "data": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> addPost({required Post postData}) async {
    try {
      await _firestore.collection('posts').doc().set(postData.toJson());

      return {
        "status": "Posted Success",
        "data": "User added successfully",
      };
    } catch (e) {
      return {
        "status": "failed",
        "data": e.toString(),
      };
    }
  }

  Stream<List<Post>> fetchData() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Post(
          title: doc['title'] ?? '',
          desc: doc['desc'] ?? '',
          email: doc['email'] ?? '',
          postedOn: doc['postedOn']?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }
}
