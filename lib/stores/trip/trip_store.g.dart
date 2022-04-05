// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TripStore on _TripStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_TripStore.isLoading'))
      .value;
  Computed<bool>? _$isTripBookedComputed;

  @override
  bool get isTripBooked =>
      (_$isTripBookedComputed ??= Computed<bool>(() => super.isTripBooked,
              name: '_TripStore.isTripBooked'))
          .value;

  final _$successAtom = Atom(name: '_TripStore.success');

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

  final _$loaderAtom = Atom(name: '_TripStore.loader');

  @override
  bool get loader {
    _$loaderAtom.reportRead();
    return super.loader;
  }

  @override
  set loader(bool value) {
    _$loaderAtom.reportWrite(value, super.loader, () {
      super.loader = value;
    });
  }

  final _$tripBookedAtom = Atom(name: '_TripStore.tripBooked');

  @override
  bool get tripBooked {
    _$tripBookedAtom.reportRead();
    return super.tripBooked;
  }

  @override
  set tripBooked(bool value) {
    _$tripBookedAtom.reportWrite(value, super.tripBooked, () {
      super.tripBooked = value;
    });
  }

  final _$_TripStoreActionController = ActionController(name: '_TripStore');

  @override
  Stream<QuerySnapshot<Object?>> getAllTripList() {
    final _$actionInfo = _$_TripStoreActionController.startAction(
        name: '_TripStore.getAllTripList');
    try {
      return super.getAllTripList();
    } finally {
      _$_TripStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic bookedTrip(String? id, int i) {
    final _$actionInfo =
        _$_TripStoreActionController.startAction(name: '_TripStore.bookedTrip');
    try {
      return super.bookedTrip(id, i);
    } finally {
      _$_TripStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getAllTripListTwo() {
    final _$actionInfo = _$_TripStoreActionController.startAction(
        name: '_TripStore.getAllTripListTwo');
    try {
      return super.getAllTripListTwo();
    } finally {
      _$_TripStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getBookedTripList() {
    final _$actionInfo = _$_TripStoreActionController.startAction(
        name: '_TripStore.getBookedTripList');
    try {
      return super.getBookedTripList();
    } finally {
      _$_TripStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
loader: ${loader},
tripBooked: ${tripBooked},
isLoading: ${isLoading},
isTripBooked: ${isTripBooked}
    ''';
  }
}
