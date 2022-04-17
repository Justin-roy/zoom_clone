import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign with google
  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential cred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (cred.user != null) {
        String message = await uploadUserDetails(
            username: cred.user!.displayName!, email: cred.user!.email!);
        return (message == 'Success') ? true : false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  // sign with facebook
  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential cred = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      if (cred.user != null) {
        String message = await uploadUserDetails(
            username: cred.user!.displayName!, email: cred.user!.email!);

        return (message == 'Success') ? true : false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  // this upload sign in details
  Future<String> uploadUserDetails({
    required String username,
    required String email,
  }) async {
    String res = 'some error occured';
    try {
      // Now All Data Uploading to firebase
      String postId = const Uuid().v1();
      _firestore.collection('Users').doc(postId).set({
        'username': username,
        'email': email,
      });
      res = 'Success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // this will upload zoom details
  Future<String> uploadZoomDetails({
    required String username,
    required String meetingId,
  }) async {
    String res = 'some error occured';
    try {
      // Now All Data Uploading to firebase
      String postId = const Uuid().v1();
      _firestore.collection('Zoom').doc(postId).set({
        'username': username,
        'meetingId': meetingId,
      });
      res = 'Success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
