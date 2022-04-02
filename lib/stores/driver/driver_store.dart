import 'package:flutter_tour_app_firebase/data/driver_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/models/app/driver.dart';
import 'package:flutter_tour_app_firebase/stores/error/error_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';


part 'driver_store.g.dart';

class DriverStore = _DriverStore with _$DriverStore;
abstract class _DriverStore with Store {
  // repository instance
  final DriverFireStoreRepository _repository;

  // store for handling form errors

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;
  @observable
  bool isDriverCreated=false;

  @computed
  bool get loading => isDriverCreated;

  // constructor:---------------------------------------------------------------
  _DriverStore(DriverFireStoreRepository repository) : this._repository = repository {

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
  static ObservableFuture<DocumentReference?> emptyLoginResponse =
  ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<DocumentReference?> addDriverTask = emptyLoginResponse;

  @computed
  bool get isLoading => addDriverTask.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future addDriver(String name, number,String vendor_code,Position _driverposition) async {

    this.isDriverCreated=true;

    Driver driver=new Driver(name,"refid",_driverposition.latitude.toString(),_driverposition.longitude.toString(),driver_number:number, vendor_code: vendor_code);
    final future = _repository.addDriver(driver);
    addDriverTask= ObservableFuture(future);
    await future.then((value) async {
      this.isDriverCreated=false;
      this.success = true;

    }).catchError((e) {
      //print(e);
      this.isDriverCreated=false;
      this.success = false;
      throw e;
    });
  }
  @action
  Future showDriver(String name, number,String businessCode) async {
  }



  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}