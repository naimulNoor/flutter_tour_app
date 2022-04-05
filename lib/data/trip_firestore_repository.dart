import 'package:flutter_tour_app_firebase/models/app/trip_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TripFireStoreRepository {

  final CollectionReference collection = FirebaseFirestore.instance.collection('Innenlandsturer');
  final CollectionReference collectionTwo = FirebaseFirestore.instance.collection('Utenlandsturer');

  Stream<QuerySnapshot> getTripList() {
    return collection.where("type",isEqualTo: 0).snapshots();
  }
  Stream<QuerySnapshot> getTripListTwo() {
    return collection.where("type",isEqualTo: 1).snapshots();
  }

  Future<DocumentReference> addVendor(Trip vendor) {
    print("vendro-firebase");
    return collection.add(vendor.toJson());

  }

  void bookedTip(String id,int i) async {
    if(i==0){
      await collection.doc(id).update({"isbooked":true});
    }else{
      await collection.doc(id).update({"isbooked":true});
    }

  }
  Stream<QuerySnapshot> getBookedTripList() {
    return collection.where("isbooked",isEqualTo: true).snapshots();
  }



}
