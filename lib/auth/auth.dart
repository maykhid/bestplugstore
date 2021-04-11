// main functions for email auth
import 'package:best_plug_gadgets/services/store/firestore.dart';
import 'package:best_plug_gadgets/services/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// abstract for EmailAuth
abstract class EmailAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  currentUser();
  Future<void> signOut();
}

// abstract for GoogleAuth
abstract class GoogleAuth {
  Future<String> signInWithGoogle();
}

// user login statuses
enum Status {
  Unininitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  NewUser
}

class Auth with ChangeNotifier implements EmailAuth, GoogleAuth {
  final FirebaseAuth _firebaseAuth;
  User _user;
  Status _status = Status.Unininitialized;
  Firestrore store;

  Auth.instance(this._firebaseAuth) {
    _firebaseAuth.authStateChanges().listen(onAuthStateChanged);
    print('This is the status #on instantiating Auth -> ${_status.toString()}');
  }

  Status get status => _status;
  User get user => _user;

  /// This function is to be called on cases where
  /// updating status is needed
  updateStatus(Status status) {
    _status = status;
    print('This is the status #on updateStatus Auth -> ${_status.toString()}');
    notifyListeners();
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      updateStatus(Status.Authenticating);
      print(
          'This is the status #on createUserWithEmailAndPassword -> ${_status.toString()}');
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // assert(!currentUser() == null);

      // await store.addUserToDb(
      //     uid: currentUser(),
      //     email: email,
      //     time: DateTime.now(),
      //     username: username);

      return currentUser();
    } on FirebaseAuthException catch (e) {
      updateStatus(Status.Unauthenticated);
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  /// Returns currentUser uid
  @override
  currentUser() {
    _user = _firebaseAuth.currentUser;
    notifyListeners();
    return _user?.uid;
  }

  // signInWithEmailAndPassword
  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      updateStatus(Status.Authenticating);
      print(
          'This is the status #on signInWithPassword -> ${_status.toString()}');
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return currentUser();
    } on FirebaseAuthException catch (e) {
      updateStatus(Status.Unauthenticated);
      print(
          'This is the status #on signInWithPassword -> ${_status.toString()}');
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
    updateStatus(Status.Unauthenticated);
  }

  Future<void> onAuthStateChanged(User user) async {
    if (user == null) {
      updateStatus(Status.Unauthenticated);
      print('This is the status #onAuthStateChanged -> ${_status.toString()}');
    } else {
      _user = user;
      updateStatus(Status.Authenticated);
      print('This is the status #onAuthStateChanged -> ${_status.toString()}');
    }
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
  Future<void> validateAndSubmit(
      GlobalKey<FormState> formKey, String email, String password) async {
    try {
      if (validateAndSave(formKey)) {
        // if (formType == FormType.login) {
        final String userId = await signInWithEmailAndPassword(email, password);
        print('Logged In: $userId');
      }
    }
    // else {
    //   final String userId = await createUserWithEmailAndPassword(
    //       email, password, username, DateTime.now());
    //   print('Signed Up: $userId');
    // }
    catch (e) {
      print('Error: $e');
    }
  }
  // notifyListeners();

  Future<void> validateAndSignUp(GlobalKey<FormState> formKey, String email,
      String password, String username) async {
    try {
      if (validateAndSave(formKey)) {
        final String userId =
            await createUserWithEmailAndPassword(email, password);
        print('Signed Up: $userId');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    updateStatus(Status.Authenticating);
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    try {
      // final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      // return userCredential.user.uid;
      return currentUser();
    } on FirebaseAuthException catch (e) {
      updateStatus(Status.Unauthenticated);

      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        return 'account-exists-with-different-credential';
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        return 'invalid-credential';
      } else
        return "Something went wrong";
    }
  }
}
