import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qq/utility/utility.dart';

enum QueueStatus { waiting, success, cancel, inprogress }
const Map<QueueStatus, MaterialColor> queueStatusColor = {
  QueueStatus.waiting: Colors.blue,
  QueueStatus.success: Colors.green,
  QueueStatus.cancel: Colors.red,
  QueueStatus.inprogress: Colors.purple,
};

/*
waiting รอคิว
success สำเร็จใช้บริการเรียบร้อย
cancel ยกเลิกคิว
inprogress ได้คิวแล้วกำลังไปให้ร้านเช็คอิน
 */

class QueueTransaction extends Equatable {
  final String id;
  final DocumentReference resId;
  final DocumentReference userId;
  final Timestamp timestamp;
  final bool isQueue;
  final String status;
  final int queueNumber;
  //

  QueueTransaction({
    this.id,
    @required this.resId,
    @required this.userId,
    @required this.timestamp,
    @required this.isQueue,
    @required this.status,
    @required this.queueNumber,
  }) : assert(resId != null, userId != null);

  @override
  List<Object> get props =>
      [id, resId, userId, timestamp, isQueue, queueNumber];

  Map<String, Object> toJson() {
    return {
      'id': id,
      'resId': resId,
      'userId': userId,
      'timestamp': timestamp,
      'isQueue': isQueue,
      'queueNumber': queueNumber,
    };
  }

  Map<String, Object> toDocument() {
    return {
      'resId': resId,
      'userId': userId,
      'timestamp': timestamp,
      'isQueue': isQueue,
      'status': status,
      'queueNumber': queueNumber,
    };
  }

  static QueueTransaction fromJson(Map<String, Object> json) {
    return QueueTransaction(
      id: json['id'] as String,
      resId: json['resId'] as DocumentReference,
      userId: json['userId'] as DocumentReference,
      timestamp: json['timestamp'] as Timestamp,
      isQueue: json['isQueue'] as bool,
      status: json['status'] as String,
      queueNumber: json['queueNumber'] as int,
    );
  }

  static QueueTransaction fromSnapShot(DocumentSnapshot snap) {
    return QueueTransaction(
      id: snap.id,
      resId: snap['resId'] as DocumentReference,
      userId: snap['userId'] as DocumentReference,
      timestamp: snap['timestamp'] as Timestamp,
      isQueue: snap['isQueue'] as bool,
      status: snap['status'] as String,
      queueNumber: snap['queueNumber'] as int,
    );
  }
}
