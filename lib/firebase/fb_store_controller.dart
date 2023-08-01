import 'package:app_auth/models/fb_response.dart';
import 'package:app_auth/models/users.dart';
import 'package:app_auth/utils/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbStoreController with FirebaseHelper {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  Future<FbResponse> create(Users users) async {
    return _storage
        .collection('Users')
        .add(users.toMap())
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }

  Future<FbResponse> update(Users users) async {
    return _storage
        .collection('Users')
        .doc(users.id)
        .update(users.toMap())
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }

  Future<FbResponse> delete(String id) async {
    return _storage
        .collection('Users')
        .doc(id)
        .delete()
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }

  Stream<QuerySnapshot<Users>> search(String name) async* {
    yield* _storage
        .collection('Users')
        .where('name', isEqualTo: name)
        .withConverter<Users>(
          fromFirestore: (snapshot, options) => Users.fromMap(snapshot.data()!),
          toFirestore: (Users value, options) => value.toMap(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<Users>> read() async* {
    yield* _storage
        .collection('Users')
        .withConverter<Users>(
          fromFirestore: (snapshot, options) => Users.fromMap(snapshot.data()!),
          toFirestore: (Users value, options) => value.toMap(),
        )
        .snapshots();
  }
}
