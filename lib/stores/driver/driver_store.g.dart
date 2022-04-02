// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DriverStore on _DriverStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_DriverStore.loading'))
      .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_DriverStore.isLoading'))
      .value;

  final _$isDriverCreatedAtom = Atom(name: '_DriverStore.isDriverCreated');

  @override
  bool get isDriverCreated {
    _$isDriverCreatedAtom.reportRead();
    return super.isDriverCreated;
  }

  @override
  set isDriverCreated(bool value) {
    _$isDriverCreatedAtom.reportWrite(value, super.isDriverCreated, () {
      super.isDriverCreated = value;
    });
  }

  final _$successAtom = Atom(name: '_DriverStore.success');

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

  final _$addDriverTaskAtom = Atom(name: '_DriverStore.addDriverTask');

  @override
  ObservableFuture<DocumentReference<Object?>?> get addDriverTask {
    _$addDriverTaskAtom.reportRead();
    return super.addDriverTask;
  }

  @override
  set addDriverTask(ObservableFuture<DocumentReference<Object?>?> value) {
    _$addDriverTaskAtom.reportWrite(value, super.addDriverTask, () {
      super.addDriverTask = value;
    });
  }

  final _$addDriverAsyncAction = AsyncAction('_DriverStore.addDriver');

  @override
  Future<dynamic> addDriver(String name, dynamic number, String vendor_code,
      Position _driverposition) {
    return _$addDriverAsyncAction
        .run(() => super.addDriver(name, number, vendor_code, _driverposition));
  }

  final _$showDriverAsyncAction = AsyncAction('_DriverStore.showDriver');

  @override
  Future<dynamic> showDriver(String name, dynamic number, String businessCode) {
    return _$showDriverAsyncAction
        .run(() => super.showDriver(name, number, businessCode));
  }

  @override
  String toString() {
    return '''
isDriverCreated: ${isDriverCreated},
success: ${success},
addDriverTask: ${addDriverTask},
loading: ${loading},
isLoading: ${isLoading}
    ''';
  }
}
