import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:qq/models/queue_transaction.dart';
import 'package:qq/net/queue_repository.dart';
import 'package:qq/net/restaurant_repository.dart';

part 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  final QueueRepository _queueRepository = QueueRepository();

  QueueCubit() : super(const QueueState());

  Future<void> addQueue({
    String resId,
    String userId,
  }) async {
    RestaurantRepository restaurantRepository = RestaurantRepository();
    emit(state.copyWith(status: QueueEventStatus.inprogress));

    try {
      int currentQueue = await restaurantRepository.getCurrentQueue(resId);
      QueueTransaction queue = QueueTransaction(
        resId: FirebaseFirestore.instance.collection("restaurant").doc(resId),
        userId: FirebaseFirestore.instance.collection("user").doc(userId),
        timestamp: Timestamp.now(),
        isQueue: true,
        status: 'waiting',
        queueNumber: currentQueue + 1,
      );
      // await Future.delayed(Duration(seconds: 15), () {
      //   print("Complete");
      // });
      await _queueRepository.addQueue(queue);
      emit(state.copyWith(status: QueueEventStatus.success));
    } on Exception catch (exception) {
      emit(state.copyWith(
          status: QueueEventStatus.failure, error: exception.toString()));
    }
  }
}
