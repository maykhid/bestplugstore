// main functions for email auth
import 'package:best_plug_gadgets/services/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// abstract for EmailAuth
abstract class EmailAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

// abstract for GoogleAuth
abstract class GoogleAuth {}

class Auth with ChangeNotifier implements EmailAuth, GoogleAuth {
  final FirebaseAuth _firebaseAuth;
  Auth(this._firebaseAuth);

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return currentUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  @override
  Future<String> currentUser() async {
    final User user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  // signInWithEmailAndPassword
  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return currentUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  // signOut
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // validate form and save
  bool validateAndSave(GlobalKey<FormState> formKey) {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // runs validateAndSave() and submits depending on formType
  // e.g if formType == FormType.login perform signInWithEmailAndPassword
  Future<void> validateAndSubmit(GlobalKey<FormState> formKey,
      FormType formType, String email, String password) async {
    if (validateAndSave(formKey)) {
      try {
        if (formType == FormType.login) {
          final String userId =
              await signInWithEmailAndPassword(email, password);
          print('Logged In: $userId');
        } else {
          final String userId =
              await createUserWithEmailAndPassword(email, password);
          print('Signed Up: $userId');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
    // notifyListeners();
  }
}
