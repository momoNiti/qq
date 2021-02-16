import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qq/models/queue_transaction.dart';

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
              QueueTransaction queueTrans = QueueTransaction.fromSnapShot(e);
              queueTrans.queueBefore = 0;
              // queueTrans.estimateTime = 0;
              return queueTrans;
            }).toList());
  }

  Future<void> addQueue(QueueTransaction queueTransaction) async {
    try {
      await queueCollection.add(queueTransaction.toDocument());
    } on Exception {
      throw AddQueueFailure();
    }
  }
}

class AddQueueFailure implements Exception {}
