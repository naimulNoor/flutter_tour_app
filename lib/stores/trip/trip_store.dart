import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tour_app_firebase/data/trip_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/models/app/trip_model.dart';
import 'package:flutter_tour_app_firebase/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository.dart';
import '../form/form_store.dart';

part 'trip_store.g.dart';

class TripStore = _TripStore with _$TripStore;

abstract class _TripStore with Store {
  // repository instance
  final TripFireStoreRepository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _TripStore(TripFireStoreRepository repository) : this._repository = repository {

    // setting up disposers
    _setupDisposers();

  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
 // static ObservableStream<QuerySnapshot> emptyLoginResponse =ObservableStream as ObservableStream<QuerySnapshot>;

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;


  @observable
  bool loader = false;

  @computed
  bool get isLoading => loader;

  @observable
  bool tripBooked = false;

  @computed
  bool get isTripBooked => tripBooked;



  // actions:-------------------------------------------------------------------
  @action
     Stream<QuerySnapshot> getAllTripList(){
    loader =true;
    final stream = _repository.getTripList();

    return stream;

  }
  @action
     bookedTrip(String? id ,int i){
     print(id);
    loader =true;
     _repository.bookedTip(id!,i);
    tripBooked=true;
     loader =false;



  }


  @action
  Stream<QuerySnapshot> getAllTripListTwo() {
    loader = true;
    final stream = _repository.getTripListTwo();
    return stream;
  }
  @action
  Stream<QuerySnapshot> getBookedTripList() {
    loader = true;
    final stream = _repository.getBookedTripList();
    return stream;
  }



  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}