import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qq/models/user.dart' as UserModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class SignUpFailure implements Exception {}

class SignInInWithEmailAndPasswordFailure implements Exception {}

class SignOutFailure implements Exception {}

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<UserModel.User> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return UserModel.User.empty;
      }
      return await getUserData(firebaseUser.uid);
    });
  }

  Future<UserModel.User> getUserData(String uid) {
    return FirebaseFirestore.instance.collection('user').doc(uid).get().then(
        (value) => value.exists
            ? UserModel.User.fromSnapShot(value)
            : UserModel.User.empty);
  }

  Future<void> signInWithCredential(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignInInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signUp(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('user')
          .doc(result.user.uid)
          .set({
        'id': result.user.uid,
        'email': email,
        'name': result.user.displayName,
        'role': 'customer',
      });
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw SignOutFailure();
    }
  }

  Stream<List<UserModel.User>> fetchAllUser() {
    return FirebaseFirestore.instance.collection('user').snapshots().map(
          (event) =>
              event.docs.map((e) => UserModel.User.fromSnapShot(e)).toList(),
        );
  }
}
