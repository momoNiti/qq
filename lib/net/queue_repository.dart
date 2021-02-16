import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qq/models/queue_transaction.dart';
import 'package:qq/net/restaurant_repository.dart';

class QueueRepository {
  final queueCollection =
      FirebaseFirestore.instance.collection('queue_transaction');

  Stream<List<QueueTransaction>> fetchQueues() {
    return queueCollection.snapshots().map((event) =>
        event.docs.map((e) => QueueTransaction.fromSnapShot(e)).toList());
  }

  Stream<List<QueueTransaction>> fetchQueuesInRestaurant(String resId) {
    return queueCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((event) => event.docs
            .where(
              (element) =>
                  (element.data()['resId'] as DocumentReference).id == resId,
            )
            .map((e) => QueueTransaction.fromSnapShot(e))
            .toList());
  }

  Stream<List<QueueTransaction>> fetchQueueOfUser(String uid) {
    // RestaurantRepository restaurantRepository = RestaurantRepository();
    return queueCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((event) => event.docs
                .where(
              (element) =>
                  (element.data()['userId'] as DocumentReference).id == uid,
            )
                .map((e) {
              return QueueTransaction.fromSnapShot(e);
            }).toList());
  }

  Future<void> addQueue(QueueTransaction queueTransaction) async {
    DocumentReference refAdd;
    RestaurantRepository restaurantRepository = RestaurantRepository();
    try {
      refAdd = await queueCollection.add(queueTransaction.toDocument());
      try {
        await restaurantRepository.updateQueue(queueTransaction.resId, "Add");
      } on FirebaseException {
        print("Update Queue Fail");
        await refAdd.delete();
      }
    } on FirebaseException {
      print("Add Queue Error");
    }
  }
}
