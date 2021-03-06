import 'package:einstein/data/modules/account.dart';
import 'package:einstein/data/repos/db_routs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class DAccount extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();

  FirebaseAuth get auth => _auth;
  User get user => auth.currentUser!;
  String get userID => user.uid;

  void _updateData(Map<String, Map?> updates) async =>
      _db.update(updates).then((_) => notifyListeners());

  Future<Account> fetchAccountData(String? accountID) async {
    String accID = accountID ?? user.uid;
    final snapshot = await _db.child(DbRoutes.userData(accID)).get();
    return Account.fromMap(
        Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>));
  }

  void addAccount(String accountID, Account account) async {
    Map<String, Map> updates = {};
    updates[DbRoutes.userData(accountID)] = account.toMap();
    return _updateData(updates);
  }

  void deleteAccount(String accountID) async {
    Map<String, Map?> updates = {};
    updates[DbRoutes.userData(accountID)] = null;
    return _updateData(updates);
  }

  void updateAccount(String accountID, Account account) async {
    Map<String, Map> updates = {};
    updates[DbRoutes.userData(accountID)] = account.toMap();
    return _updateData(updates);
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential?> signInWithPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<UserCredential?> signUpWithPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
