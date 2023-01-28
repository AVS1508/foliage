// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:foliage/utils/tuple2.dart';

/// Register a new user with displayName, email and password, via Firebase Authentication.
Future<Tuple2<bool, String>> registerUser(String displayName, String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User currentUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
      'name': displayName,
      'email': email,
    });
    return Tuple2<bool, String>(item1: true, item2: 'Signed up with $email.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return Tuple2<bool, String>(item1: false, item2: 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      return Tuple2<bool, String>(item1: false, item2: 'The account already exists for that email.');
    }
    return Tuple2<bool, String>(item1: false, item2: e.message ?? 'Unknown error');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

/// Delete current user's account, via Firebase Authentication.
Future<Tuple2<bool, String>> deleteUser() async {
  try {
    User currentUser = FirebaseAuth.instance.currentUser!;
    await currentUser.delete();
    await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).delete();
    return Tuple2<bool, String>(item1: true, item2: 'Account associated with ${currentUser.email} deleted.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

/// Sign in user with email and password, via Firebase Authentication.
Future<Tuple2<bool, String>> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return Tuple2<bool, String>(item1: true, item2: 'Logged in as $email.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return Tuple2<bool, String>(item1: false, item2: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return Tuple2<bool, String>(item1: false, item2: 'Wrong password provided for that user.');
    }
    return Tuple2<bool, String>(item1: false, item2: e.message ?? 'Unknown error');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

/// Sign out current user, via Firebase Authentication.
Future<Tuple2<bool, String>> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return Tuple2<bool, String>(item1: true, item2: 'Signed out.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}
