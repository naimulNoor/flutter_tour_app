import 'package:flutter_tour_app_firebase/data/vendor_firestore_repository.dart';
import 'package:flutter_tour_app_firebase/models/app/vendor.dart';
import 'package:flutter_tour_app_firebase/stores/error/error_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';


part 'vendor_store.g.dart';

class VendorStore = _vendroStore with _$VendorStore;
abstract class _vendroStore with Store {
  // repository instance
  final VendorFireStoreRepository _repository;

  // store for handling form errors

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;
  @observable
  bool isVendorCreated=false;

  @computed
  bool get loading => isVendorCreated;

  // constructor:---------------------------------------------------------------
  _vendroStore(VendorFireStoreRepository repository) : this._repository = repository {

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
  ObservableFuture<DocumentReference?> addVendorTask = emptyLoginResponse;

  @computed
  bool get isLoading => addVendorTask.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future addVendor(String name, number,String businessCode) async {

    this.isVendorCreated=true;

    Vendor vendor=new Vendor(name, number,driverLIst:"no driver",businessCode: businessCode);
    final future = _repository.addVendor(vendor);
    addVendorTask= ObservableFuture(future);
    await future.then((value) async {
      this.isVendorCreated=false;
      this.success = true;

    }).catchError((e) {
      //print(e);
      this.isVendorCreated=false;
      this.success = false;
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