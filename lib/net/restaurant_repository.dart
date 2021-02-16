import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qq/models/queue_transaction.dart';

import 'package:qq/models/restaurant.dart';
import 'package:qq/net/queue_repository.dart';

class RestaurantRepository {
  final collection = FirebaseFirestore.instance.collection('restaurant');

  Stream<List<Restaurant>> fetchRestaurants() {
    return collection.snapshots().map(
        (event) => event.docs.map((e) => Restaurant.fromSnapShot(e)).toList());
  }

  Future<int> getCurrentQueue(String resId) async {
    DocumentSnapshot docSnap = await collection.doc(resId).get();
    return docSnap.get('queued');
  }

  Future<void> updateQueue(DocumentReference docRef, String action) async {
    switch (action) {
      case "Add":
        collection.doc(docRef.id).update({'queued': FieldValue.increment(1)});
        break;
      case "Delete":
        collection.doc(docRef.id).update({'queued': FieldValue.increment(-1)});
        break;
      case "Reset":
        collection.doc(docRef.id).update({'queued': 0});
        break;
      default:
    }
  }
}
