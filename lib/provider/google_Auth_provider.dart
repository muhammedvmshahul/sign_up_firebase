import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleProvider extends ChangeNotifier{

 Future<UserCredential?> googleSignIn()async{
      try{
        final  googleUser = await GoogleSignIn().signIn();
        final  googleAuth = await googleUser?.authentication;
        if(googleUser == null){
          print('user is not found');
        }
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken:googleAuth?.idToken
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } catch(e){
        print('Error is : ${e.toString()}');
      }
      notifyListeners();
 }
}