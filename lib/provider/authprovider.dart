import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authprovider extends ChangeNotifier {
  //
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
// signIn method
  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
  try{
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    notifyListeners();
  } on FirebaseAuthException catch(e){
    throw e.toString();
  }
  }
// signUp method
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch(e){
      throw e.toString();
    }

  }

  // signOut method

Future<void>signOut()async{
    await _firebaseAuth.signOut();
    notifyListeners();
}
}
