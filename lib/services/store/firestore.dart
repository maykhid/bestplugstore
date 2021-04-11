import 'package:best_plug_gadgets/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firestrore extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore;
  // bool _useFirestoreEmulator = true;
  Query _query;
  UserModel _userModel = UserModel();

  Firestrore.instance(this._firebaseFirestore);
  // if (_useFirestoreEmulator) {
  //   _firebaseFirestore.settings = const Settings(
  //       // changed this from localhost to 10.0.2.2 because
  //       // this 10.0.2.2 is the special IP address to connect to the 'localhost'
  //       // of the host computer from an Android emulator.
  //       host: '10.0.2.2:8080',
  //       sslEnabled: false,
  //       persistenceEnabled: false);
  //   print("Firestore should be running");
  // }
  // }

  // bool get userFirestoreEmulator => _useFirestoreEmulator;

  // shouldUseFirebaseEmulator(bool value) {
  //   _useFirestoreEmulator = value;
  //   notifyListeners();
  // }

  // getdata() async {
  //   _query = _firebaseFirestore.collection('users');
  //   await _query.get().then((snapshot) async {
  //     snapshot.docs.forEach((document) {
  //       if (document.exists) {
  //         Map<String, dynamic> data = document.data();
  //         print('document ${data['user']['name']}');
  //       } else
  //         print('No data abeg');
  //     });
  //   });
  // }

  Future<void> addUserToDb(
      {@required String uid, @required String email, @required String username, @required DateTime time}) async {
    _userModel =
        UserModel(uid: uid, email: email, username: username, createdAt: time);
    await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .set(_userModel.setUser(_userModel));
  }

  Future<void> getUserFromDb({String uid}) async {
    final DocumentSnapshot doc = await _firebaseFirestore.collection('users').doc(uid).get();
    return UserModel.getUser(doc.data());
  }
}
