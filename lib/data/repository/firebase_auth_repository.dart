import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour_app_firebase/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_tour_app_firebase/models/app/firebase_user.dart';

class FireAuthRepository {

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  // constructor
  FireAuthRepository(this._sharedPrefsHelper);



   Future<dynamic> registerUsingEmailPassword({
    required FirebaseAuthModel model
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    print(model.email.toString());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: model.email!,
        password: model.password!,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: model.name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

   Future<dynamic> signInUsingEmailPassword({
     required FirebaseAuthModel model,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: model.email!,
        password: model.password!,
      );
      user = userCredential.user;
      //save data to local storage
      FirebaseAuthModel newUser=FirebaseAuthModel(user?.displayName,user?.email,"");
       _sharedPrefsHelper.saveFirebaseUser(newUser.toJson());
       print("store::${_sharedPrefsHelper.getFirebaseUser.email}");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided.';
      }
    }

    return user;
  }

   firebaseUserSignOut() async{
    await FirebaseAuth.instance.signOut();
  }


}