import 'package:flutter_tour_app_firebase/models/app/driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DriverFireStoreRepository {
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('drivers');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addDriver(Driver driver) {
    return collection.add(driver.toJson());
  }

  void updateDriver(Driver driver) async {
    await collection.doc(driver.ref_id).update(driver.toJson());
  }

  void deleteDriver(Driver driver) async {
    await collection.doc(driver.ref_id).delete();
  }
}
