import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tour_app_firebase/data/driver_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/data/repository/firebase_auth_repository.dart';
import 'package:flutter_tour_app_firebase/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_tour_app_firebase/models/app/driver.dart';
import 'package:flutter_tour_app_firebase/models/app/firebase_user.dart';
import 'package:flutter_tour_app_firebase/stores/error/error_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'firebaseuser_store.g.dart';

class FirebaseUser = _FirebaseUserStore with _$FirebaseUser;
abstract class _FirebaseUserStore with Store {
  // repository instance
  final FireAuthRepository _repository;


  // store for handling form errors

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  @observable
  bool isUserCreated=false;
  @computed
  bool get loading => isUserCreated;

  @observable
  bool showErrorMsg=false;
  @computed
  bool get showMessage => showErrorMsg;

  @observable
  bool userRegister=false;
  @computed
  bool get getUserRegister => userRegister;

  @observable
  bool userLogin=false;
  @computed
  bool get getUserLogin => userLogin;

  @observable
  String errorMsg="";
  @computed
  String get getErrorMessage => errorMsg;

  // constructor:---------------------------------------------------------------
  _FirebaseUserStore(FireAuthRepository repository) : this._repository = repository {

    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    // repository.isLoggedIn.then((value) {
    //   this.isLoggedIn = value;
    // });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<dynamic> emptyLoginResponse =
  ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<dynamic> addUserTask = emptyLoginResponse;

  @computed
  bool get isLoading => addUserTask.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------

  @action
  Future registerUser(String name,String email,String password) async {
    this.isUserCreated=true;
    showErrorMsg=false;
    print("firebase-store");
    print(name);
    FirebaseAuthModel user=new FirebaseAuthModel(name,email,password);
    final future = _repository.registerUsingEmailPassword(model: user);
    addUserTask= ObservableFuture(future);
    await future.then((value) async {
      if(value is String){
        this.isUserCreated=false;
        this.userRegister=false;
        showErrorMsg=true;
        errorMsg=value;
      }else{
        this.isUserCreated=false;
        this.success = true;
        this.userRegister=true;
      }


    }).catchError((e) {
      print("error: ${e}");
      this.isUserCreated=false;
      //this.success = false;
      throw e;
    });
  }

  @action
  Future logout() async {
    final future = _repository.firebaseUserSignOut();
    return future;
  }

  @action
  Future loginUser(String email,String password,BuildContext context) async {
    //this.isUserCreated=true;
    FirebaseAuthModel user=new FirebaseAuthModel("",email,password);
    print(user.email);
    final future = _repository.signInUsingEmailPassword(model: user, context: context);
    addUserTask= ObservableFuture(future);
    await future.then((value) async {

      if(value is String){
        this.isUserCreated=false;
        showErrorMsg=true;
        errorMsg=value as String;
      }else{
        this.userLogin=true;

      }

    }).catchError((e) {
      this.isUserCreated=false;
      //this.success = false;
      throw e;
    });
  }




  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}