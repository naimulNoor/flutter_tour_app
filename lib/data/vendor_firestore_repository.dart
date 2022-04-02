import 'package:flutter_tour_app_firebase/models/app/vendor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class VendorFireStoreRepository {

  final CollectionReference collection = FirebaseFirestore.instance.collection('vendors');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addVendor(Vendor vendor) {
    print("vendro-firebase");
    return collection.add(vendor.toJson());

  }

  void updatePet(Vendor vendor) async {
    await collection.doc(vendor.referenceId).update(vendor.toJson());
  }

  void deletePet(Vendor vendor) async {
    await collection.doc(vendor.referenceId).delete();
  }
}
