// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:foliage/utils/tuple2.dart';

Future<Tuple2<bool, String>> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return Tuple2<bool, String>(item1: true, item2: 'Logged in as $email.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return Tuple2<bool, String>(
          item1: false, item2: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return Tuple2<bool, String>(
          item1: false, item2: 'Wrong password provided for that user.');
    }
    return Tuple2<bool, String>(
        item1: false, item2: e.message ?? 'Unknown error');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

Future<Tuple2<bool, String>> register(
    String displayName, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
    return Tuple2<bool, String>(item1: true, item2: 'Signed up with $email.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return Tuple2<bool, String>(
          item1: false, item2: 'The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      return Tuple2<bool, String>(
          item1: false, item2: 'The account already exists for that email.');
    }
    return Tuple2<bool, String>(
        item1: false, item2: e.message ?? 'Unknown error');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

Future<Tuple2<bool, String>> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return Tuple2<bool, String>(item1: true, item2: 'Signed out.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

Future<Tuple2<bool, String>> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
      } else {
        double newAmount = snapshot.get('Amount') + value;
        transaction.update(documentReference, {'Amount': newAmount});
      }
    });
    return Tuple2<bool, String>(
        item1: true, item2: '$amount tokens of $id added to Wallet.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

Future<Tuple2<bool, String>> removeCoin(String id) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id)
        .delete();
    return Tuple2<bool, String>(
        item1: true, item2: 'Coin $id removed from Wallet.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}
