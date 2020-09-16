//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_locks_admin/models/brands.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'brands';

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();

    _firestore.collection(ref).doc(brandId).set({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() =>
      _firestore.collection(ref).get().then((snaps) {
        print(snaps.docs.length);
        return snaps.docs;
      });

  //  //Brand list from snapshot
  // List<Brand> _brandslistFromSnapshot(QuerySnapshot snapshot) {
  //    return snapshot.docs
  //        .map((doc) => Brand(brand: doc.data()['brand'] ?? '');)
  //        .toList();
  //  }
  //
  //  //Get brands stream
  //  Stream<List<Brand>> get brands {
  //    return _firestore.collection(ref).snapshots().map(_brandslistFromSnapshot);
  //  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('brand', isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
