// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebaseuser_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FirebaseUser on _FirebaseUserStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_FirebaseUserStore.loading'))
      .value;
  Computed<bool>? _$showMessageComputed;

  @override
  bool get showMessage =>
      (_$showMessageComputed ??= Computed<bool>(() => super.showMessage,
              name: '_FirebaseUserStore.showMessage'))
          .value;
  Computed<bool>? _$getUserRegisterComputed;

  @override
  bool get getUserRegister =>
      (_$getUserRegisterComputed ??= Computed<bool>(() => super.getUserRegister,
              name: '_FirebaseUserStore.getUserRegister'))
          .value;
  Computed<bool>? _$getUserLoginComputed;

  @override
  bool get getUserLogin =>
      (_$getUserLoginComputed ??= Computed<bool>(() => super.getUserLogin,
              name: '_FirebaseUserStore.getUserLogin'))
          .value;
  Computed<String>? _$getErrorMessageComputed;

  @override
  String get getErrorMessage => (_$getErrorMessageComputed ??= Computed<String>(
          () => super.getErrorMessage,
          name: '_FirebaseUserStore.getErrorMessage'))
      .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_FirebaseUserStore.isLoading'))
          .value;

  final _$isUserCreatedAtom = Atom(name: '_FirebaseUserStore.isUserCreated');

  @override
  bool get isUserCreated {
    _$isUserCreatedAtom.reportRead();
    return super.isUserCreated;
  }

  @override
  set isUserCreated(bool value) {
    _$isUserCreatedAtom.reportWrite(value, super.isUserCreated, () {
      super.isUserCreated = value;
    });
  }

  final _$showErrorMsgAtom = Atom(name: '_FirebaseUserStore.showErrorMsg');

  @override
  bool get showErrorMsg {
    _$showErrorMsgAtom.reportRead();
    return super.showErrorMsg;
  }

  @override
  set showErrorMsg(bool value) {
    _$showErrorMsgAtom.reportWrite(value, super.showErrorMsg, () {
      super.showErrorMsg = value;
    });
  }

  final _$userRegisterAtom = Atom(name: '_FirebaseUserStore.userRegister');

  @override
  bool get userRegister {
    _$userRegisterAtom.reportRead();
    return super.userRegister;
  }

  @override
  set userRegister(bool value) {
    _$userRegisterAtom.reportWrite(value, super.userRegister, () {
      super.userRegister = value;
    });
  }

  final _$userLoginAtom = Atom(name: '_FirebaseUserStore.userLogin');

  @override
  bool get userLogin {
    _$userLoginAtom.reportRead();
    return super.userLogin;
  }

  @override
  set userLogin(bool value) {
    _$userLoginAtom.reportWrite(value, super.userLogin, () {
      super.userLogin = value;
    });
  }

  final _$errorMsgAtom = Atom(name: '_FirebaseUserStore.errorMsg');

  @override
  String get errorMsg {
    _$errorMsgAtom.reportRead();
    return super.errorMsg;
  }

  @override
  set errorMsg(String value) {
    _$errorMsgAtom.reportWrite(value, super.errorMsg, () {
      super.errorMsg = value;
    });
  }

  final _$successAtom = Atom(name: '_FirebaseUserStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$addUserTaskAtom = Atom(name: '_FirebaseUserStore.addUserTask');

  @override
  ObservableFuture<dynamic> get addUserTask {
    _$addUserTaskAtom.reportRead();
    return super.addUserTask;
  }

  @override
  set addUserTask(ObservableFuture<dynamic> value) {
    _$addUserTaskAtom.reportWrite(value, super.addUserTask, () {
      super.addUserTask = value;
    });
  }

  final _$registerUserAsyncAction =
      AsyncAction('_FirebaseUserStore.registerUser');

  @override
  Future<dynamic> registerUser(String name, String email, String password) {
    return _$registerUserAsyncAction
        .run(() => super.registerUser(name, email, password));
  }

  final _$logoutAsyncAction = AsyncAction('_FirebaseUserStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$loginUserAsyncAction = AsyncAction('_FirebaseUserStore.loginUser');

  @override
  Future<dynamic> loginUser(
      String email, String password, BuildContext context) {
    return _$loginUserAsyncAction
        .run(() => super.loginUser(email, password, context));
  }

  @override
  String toString() {
    return '''
isUserCreated: ${isUserCreated},
showErrorMsg: ${showErrorMsg},
userRegister: ${userRegister},
userLogin: ${userLogin},
errorMsg: ${errorMsg},
success: ${success},
addUserTask: ${addUserTask},
loading: ${loading},
showMessage: ${showMessage},
getUserRegister: ${getUserRegister},
getUserLogin: ${getUserLogin},
getErrorMessage: ${getErrorMessage},
isLoading: ${isLoading}
    ''';
  }
}
