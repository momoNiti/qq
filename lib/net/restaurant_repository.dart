import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qq/models/queue_transaction.dart';

import 'package:qq/models/restaurant.dart';
import 'package:qq/net/queue_repository.dart';
import 'package:rxdart/rxdart.dart';

class RestaurantRepository {
  Stream<List<Restaurant>> fetchRestaurants() {
    return FirebaseFirestore.instance.collection('restaurant').snapshots().map(
        (event) => event.docs.map((e) => Restaurant.fromSnapShot(e)).toList());
  }

  Stream<List<Restaurant>> fetchRestaurantsWithQueue() {
    QueueRepository queueRepository = QueueRepository();
    return Rx.combineLatest2(fetchRestaurants(), queueRepository.fetchQueues(),
        (List<Restaurant> restaurant, List<QueueTransaction> queue) {
      return restaurant.map((e) {
        var count = queue.where((element) {
          return element.resId.id == e.id && element.isQueue;
        }).length;
        e.queued = count;
        return e;
      }).toList();
    });
  }
}
