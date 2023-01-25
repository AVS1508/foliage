// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:foliage/utils/tuple2.dart';

/// Create new cryptocurrency amount or add to the existing cryptocurrency amount in the user's wallet.
Future<Tuple2<bool, String>> addCryptocurrency(String id, String amount) async {
  try {
    User currentUser = FirebaseAuth.instance.currentUser!;
    final addAmount = double.parse(amount);
    if (addAmount <= 0) {
      return Tuple2<bool, String>(item1: false, item2: 'Amount must be greater than 0.');
    }
    final DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(currentUser.uid).collection('cryptocurrencies').doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(documentReference);
      double newAmount = (snapshot.exists) ? snapshot.get('amount') + addAmount : addAmount;
      transaction.set(documentReference, {'amount': newAmount});
    });
    return Tuple2<bool, String>(item1: true, item2: '$amount tokens of $id added to wallet.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

/// Get the details for cryptocurrencies in the user's wallet.
Future<Tuple2<bool, Map<String, dynamic>>> getCryptocurrencies() async {
  try {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    return Tuple2<bool, Map<String, dynamic>>(item1: true, item2: documentSnapshot.get('cryptocurrencies'));
  } catch (e) {
    return Tuple2<bool, Map<String, dynamic>>(item1: false, item2: {});
  }
}

/// Get the details for specified cryptocurrency in the user's wallet.
Future<Tuple2<bool, Map<String, dynamic>>> getCryptocurrencyById(String id) async {
  try {
    User currentUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).collection('cryptocurrencies').doc(id).get();
    return Tuple2<bool, Map<String, dynamic>>(item1: true, item2: documentSnapshot.data() as Map<String, dynamic>);
  } catch (e) {
    return Tuple2<bool, Map<String, dynamic>>(item1: false, item2: {});
  }
}

/// Update the existing cryptocurrency amount in the user's wallet.
Future<Tuple2<bool, String>> updateCryptocurrency(String id, String amount) async {
  try {
    User currentUser = FirebaseAuth.instance.currentUser!;
    final updatedAmount = double.parse(amount);
    if (updatedAmount <= 0) {
      return Tuple2<bool, String>(item1: false, item2: 'Amount must be greater than 0.');
    }
    await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).collection('cryptocurrencies').doc(id).set({'amount': updatedAmount});
    return Tuple2<bool, String>(item1: true, item2: 'Total tokens of $id set to $amount in wallet.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}

/// Delete an existing cryptocurrency from the user's wallet.
Future<Tuple2<bool, String>> removeCryptocurrency(String id) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).collection('cryptocurrencies').doc(id).delete();
    return Tuple2<bool, String>(item1: true, item2: 'Cryptocurrency $id removed from wallet.');
  } catch (e) {
    return Tuple2<bool, String>(item1: false, item2: e.toString());
  }
}
