import 'package:app_auth/models/fb_response.dart';
import 'package:app_auth/models/messages.dart';
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

  Stream<QuerySnapshot<Users>> read() async* {
    yield* _storage
        .collection('Users')
        .withConverter<Users>(
          fromFirestore: (snapshot, options) => Users.fromMap(snapshot.data()!),
          toFirestore: (Users value, options) => value.toMap(),
        )
        .snapshots();
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

  Future<FbResponse> sendMessage(Messages messages) async {
    return _storage
        .collection('Chat')
        .doc(chatRoomId(
          messages.senderId.toString(),
          messages.receiverId.toString(),
        ))
        .collection('messages')
        .add(messages.toMap())
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }

  Stream<QuerySnapshot<Messages>> readMessages(Messages messages) async* {
    yield* _storage
        .collection('Chat')
        .doc(chatRoomId(
          messages.senderId.toString(),
          messages.receiverId.toString(),
        ))
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Messages.forMap(snapshot.data()!),
          toFirestore: (Messages value, options) => value.toMap(),
        )
        .snapshots();
  }

  String? chatRoomId(String sendId, receiverID) {
    if (sendId[0].toLowerCase().codeUnits[0] >
        receiverID[0].toLowerCase().codeUnits[0]) {
      return '${receiverID}_${sendId}';
    }

    return '${sendId}_${receiverID}';
  }
}
